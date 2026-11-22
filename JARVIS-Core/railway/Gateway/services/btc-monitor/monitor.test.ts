import {test, expect} from "bun:test";
import {verifyPayment} from "./monitor";
const txid="a".repeat(64);
const address="bc1qdmzr4m78ulj2saa97vg9kmpzuxu3477gvc2rct";
const mock=(confirmed:boolean, match=true):typeof fetch => (async (url: string | URL | Request) => {
 const u=String(url);
 if(u.endsWith("/blocks/tip/height")) return new Response("105",{status:200});
 return Response.json({txid,vout:[{scriptpubkey_address:match?address:"bc1qother",value:12345}],status:{confirmed,block_height:confirmed?100:undefined}});
}) as typeof fetch;
test("confirmed output is read-only and correctly counted",async()=>{
 const result=await verifyPayment(txid,0,address,mock(true));
 expect(result?.amountSats).toBe(12345);
 expect(result?.confirmations).toBe(6);
});
test("unconfirmed output never counts as confirmed",async()=>{
 const result=await verifyPayment(txid,0,address,mock(false));
 expect(result?.confirmations).toBe(0);
});
test("address mismatch is rejected",async()=>{
 expect(await verifyPayment(txid,0,address,mock(true,false))).toBeNull();
});
test("invalid txid and output index rejected",async()=>{
 expect(verifyPayment("not-a-tx",0,address,mock(true))).rejects.toThrow();
 expect(verifyPayment(txid,-1,address,mock(true))).rejects.toThrow();
});
test("provider failures do not count as payment",async()=>{
 const failing=(async()=>new Response("unavailable",{status:503})) as typeof fetch;
 expect(verifyPayment(txid,0,address,failing)).rejects.toThrow();
});

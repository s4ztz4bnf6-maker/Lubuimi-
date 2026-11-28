import {test,expect} from "bun:test";
import {runAcrossModels,configuredChatModels,type ModelEndpoint} from "./model-capability-router";
const provider=(id:string,run:ModelEndpoint["invoke"]):ModelEndpoint=>({id,kind:"open_source",capabilities:["text"],enabled:true,costPerAttempt:0,invoke:run});
test("falls back from unavailable provider to successful external model",async()=>{
 const result=await runAcrossModels("text","hello",[
  provider("a",async()=>({ok:false,error:"unavailable"})),
  provider("b",async()=>({ok:true,output:"world"}))]);
 expect(result).toMatchObject({ok:true,output:"world",modelId:"b",attempted:["a","b"]});
});
test("does not switch to another provider on permission denial",async()=>{
 const result=await runAcrossModels("text","hello",[
  provider("a",async()=>({ok:false,error:"permission_denied"})),
  provider("b",async()=>({ok:true,output:"world"}))]);
 expect(result).toMatchObject({ok:false,reason:"permission_denied",attempted:["a"]});
});
test("reuses legacy Railway model configuration",()=>{
 const models=configuredChatModels({MODEL_BASE_URL:"https://example.org/v1/chat/completions",MODEL_NAME:"test-model",MODEL_API_KEY:"placeholder"});
 expect(models.length).toBe(1);expect(models[0].id).toBe("LEGACY");
});
test("rejects invalid provider URLs",()=>{
 expect(configuredChatModels({MODEL_BASE_URL:"file:///etc/passwd",MODEL_NAME:"test"})).toHaveLength(0);
});

import test from "node:test";
import assert from "node:assert/strict";
import {generateKeyPairSync} from "node:crypto";
import {deliveryToken} from "./githubAuth.mjs";
test("PAT fallback, missing credentials, signed JWT and cache",async()=>{
 assert.equal(await deliveryToken({GITHUB_DELIVERY_TOKEN:"mock"}),"mock");
 await assert.rejects(deliveryToken({}),/MissingDeliveryCredentials/);
 const {privateKey}=generateKeyPairSync("rsa",{modulusLength:2048});
 const env={GITHUB_APP_ID:"123",GITHUB_INSTALLATION_ID:"456",GITHUB_PRIVATE_KEY:privateKey.export({type:"pkcs8",format:"pem"}).replace(/\n/g,"\\n")};
 let calls=0;
 const request=async(url,o)=>{calls++;assert.ok(url.endsWith("/456/access_tokens"));assert.equal(o.headers.authorization.split(".").length,3);return {ok:true,json:async()=>({token:"mock-installation",expires_at:new Date(Date.now()+3600000).toISOString()})}};
 assert.equal(await deliveryToken(env,request),"mock-installation");
 assert.equal(await deliveryToken(env,request),"mock-installation");assert.equal(calls,1);
});

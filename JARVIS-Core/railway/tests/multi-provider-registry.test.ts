import { test, expect } from "bun:test";
import { availableModels, updateHealth, modelRegistryFromJson } from "../lib/AutonomousWorker/multi-provider-registry";
const endpoint = {id:"example",provider:"example",baseUrl:"https://api.example.org/v1",model:"free-model",apiKeyEnv:"EXAMPLE_API_KEY",freeTierVerified:false,supportsTools:true,enabled:true};
test("reject HTTP endpoints",()=>expect(()=>modelRegistryFromJson(JSON.stringify([{...endpoint,baseUrl:"http://example.org"}]))).toThrow());
test("exclude missing credentials",()=>expect(availableModels([endpoint],{}, {},0)).toHaveLength(0));
test("select configured and healthy",()=>expect(availableModels([endpoint],{}, {EXAMPLE_API_KEY:"present"},0,true)).toHaveLength(1));
test("cooldown after rate limit",()=>{
 const h=updateHealth(undefined,429,1000,120000);
 expect(availableModels([endpoint],{example:h},{EXAMPLE_API_KEY:"present"},1001)).toHaveLength(0);
 expect(availableModels([endpoint],{example:h},{EXAMPLE_API_KEY:"present"},121000)).toHaveLength(1);
});

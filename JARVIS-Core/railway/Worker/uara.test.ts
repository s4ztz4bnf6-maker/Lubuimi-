import {test,expect} from "bun:test";
import {executeRegistration} from "./uara";
const policy={platform:"fixture",registrationUrl:"https://example.com/register",policyUrl:"https://example.com/policy",automationAllowed:true,zeroCost:true,reviewedAt:"2026-11-25"};
const input={email:"fixture@example.com",idempotencyKey:"fixture-1"};
test("denied policy never invokes adapter",async()=>{let called=false;const result=await executeRegistration({...policy,automationAllowed:false},{platform:"fixture",async register(){called=true;throw Error();}},input);expect(result.status).toBe("blocked");expect(called).toBe(false);});
test("verification remains pending",async()=>{const result=await executeRegistration(policy,{platform:"fixture",async register(){return {status:"awaiting_verification",evidence:"fixture verification required"};}},input);expect(result.status).toBe("awaiting_verification");});
test("cost blocks execution",async()=>{expect((await executeRegistration({...policy,zeroCost:false},{platform:"fixture",async register(){throw Error();}},input)).status).toBe("blocked");});

import {test} from "node:test";
import assert from "node:assert/strict";
import {evaluate,departments,CentralSupervisor} from "../supervisor/central-supervisor.mjs";
test("eight departments and fail closed policy",()=>{assert.equal(departments.length,8);for(const a of ["spend","license","identity","unknown","toString"])assert.equal(evaluate(a,true).allowed,false);assert.equal(evaluate("repair",false).allowed,false);assert.equal(evaluate("discover").allowed,true);});
test("payload cannot self verify",async()=>{const s=new CentralSupervisor({sql:null,verificationProvider:async()=>false});assert.equal((await s.dispatch({id:"1",department:"finance",action:"repair",verificationPassed:true})).allowed,false);});
test("unwired department cannot claim dispatch",async()=>{const s=new CentralSupervisor({sql:null});assert.equal((await s.dispatch({id:"1",department:"finance",action:"discover"})).reason,"handler_unavailable");});

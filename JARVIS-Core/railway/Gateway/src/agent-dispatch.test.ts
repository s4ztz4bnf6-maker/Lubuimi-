import {test,expect} from "bun:test";
import {planDispatch,type WorkItem} from "./agent-dispatch";
const item=(id:string):WorkItem=>({id,customerAuthorized:true,paidTermsAgreed:true,estimatedCostCents:0,priority:1,state:"queued",attempts:0});
test("never exceeds concurrency",()=>{const r=planDispatch([item("a"),item("b"),item("c")],{maxParallel:2,maxRetries:3,maxNewSpendCents:0});expect(r.accepted).toHaveLength(2)});
test("rejects unapproved jobs and paid spending",()=>{const r=planDispatch([{...item("a"),customerAuthorized:false},{...item("b"),estimatedCostCents:1}],{maxParallel:10,maxRetries:3,maxNewSpendCents:0});expect(r.accepted).toEqual([])});
test("respects existing workers and retries",()=>{const r=planDispatch([{...item("running"),state:"running"},item("a"),{...item("b"),attempts:3}],{maxParallel:1,maxRetries:3,maxNewSpendCents:0});expect(r.accepted).toEqual([])});
test("does not dispatch duplicates",()=>{const r=planDispatch([item("a"),item("a")],{maxParallel:5,maxRetries:3,maxNewSpendCents:0});expect(r.accepted).toEqual(["a"])});

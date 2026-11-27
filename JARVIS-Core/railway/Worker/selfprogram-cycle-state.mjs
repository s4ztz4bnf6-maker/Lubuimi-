// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
// Pure state transition contract; does not execute external effects.
const transitions=Object.freeze({
 ANALYZE_AND_PATCH:["STORE_PROPOSAL","RETRY_WAIT","FAILED"],
 STORE_PROPOSAL:["SUBMIT_COMPANION","RETRY_WAIT","FAILED"],
 SUBMIT_COMPANION:["ISOLATED_TEST","RETRY_WAIT","FAILED"],
 ISOLATED_TEST:["COMMIT_DEV","RETRY_WAIT","FAILED"],
 COMMIT_DEV:["AWAIT_APPROVAL","RECONCILE_REQUIRED"],
 AWAIT_APPROVAL:[],
 RETRY_WAIT:["ANALYZE_AND_PATCH","FAILED"],
 RECONCILE_REQUIRED:[],FAILED:[]
});
export function advanceCycle(state,next,evidence={}){
 if(!Object.hasOwn(transitions,state.phase)||!transitions[state.phase].includes(next))throw Error("INVALID_CYCLE_TRANSITION");
 if(next==="AWAIT_APPROVAL"&&(!/^[a-f0-9]{40}$/.test(evidence.devSha??"")||evidence.testsPassed!==true))throw Error("DEV_EVIDENCE_REQUIRED");
 if(next==="RETRY_WAIT"&&(!Number.isFinite(Date.parse(evidence.nextRetryAt))||!Array.isArray(evidence.errors)||!evidence.errors.length))throw Error("RETRY_EVIDENCE_REQUIRED");
 if(state.phase==="RETRY_WAIT"&&next==="ANALYZE_AND_PATCH")throw Error("PERSISTENT_SCHEDULER_REQUIRED");
 return {...state,...evidence,phase:next,version:state.version+1,verified:false};
}

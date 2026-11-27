// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
// Copyright (c) 2026 Ta-Yoshua Lubuimi. All rights reserved.
import {validateCompanionSubmission} from "./selfprogram-companion-contract.mjs";
import {validatePatchPaths} from "./selfprogram-patch-policy.mjs";
export async function inspectCompanionSubmission({sql,authorization,expectedToken,payload,inspectGitPaths}){
 if(!payload||typeof payload.runId!=="string"||!/^[a-f0-9-]{36}$/i.test(payload.runId)||!Number.isInteger(payload.attempt)||payload.attempt<1||payload.attempt>3||!/^\d+$/.test(String(payload.proposalId)))throw Error("INVALID_IDENTITY");
 // Authenticate before querying any proposal.
 const {createHash,timingSafeEqual}=await import("node:crypto");
 const hash=s=>createHash("sha256").update(s).digest();
 if(typeof expectedToken!=="string"||expectedToken.length<32||typeof authorization!=="string"||!timingSafeEqual(hash(authorization),hash("Bearer "+expectedToken)))throw Error("INVALID_AUTH");
 const [row]=await sql`SELECT p.* FROM djo2_selfprogram_patches p JOIN djo2_selfprogram_cycles c ON c.task_id=p.task_id AND c.state->>'proposalId'=p.id::text WHERE c.run_id=${payload.runId} AND c.attempt=${payload.attempt} AND c.phase='SUBMIT_COMPANION' AND p.id=${payload.proposalId} AND p.status='pending'`;
 if(!row)throw Error("PROPOSAL_OR_CYCLE_NOT_FOUND");
 const verified=validateCompanionSubmission({authorization,expectedToken,payload,stored:row});
 const paths=await inspectGitPaths({baseCommit:row.base_commit,diff:row.diff});
 validatePatchPaths(paths);
 return {status:"preflight_valid",proposalId:verified.proposalId,sha256:verified.sha256,executionAuthorized:false};
}
// Read-only preflight. Git inspection must use a trusted isolated checkout.
// No HTTP registration or workflow dispatch is enabled by this module.

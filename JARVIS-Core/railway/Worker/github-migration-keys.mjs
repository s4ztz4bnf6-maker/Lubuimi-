import {commercialOrderKey} from "./commercial-order-idempotency.mjs";
import {githubCommercialIdentity} from "./github-commercial-identity.mjs";
import {immutableGitHubIdentity} from "./github-immutable-identity.mjs";
export function collectSymmetricOrderKeys({repositoryId,issueId,action,mappings,historyComplete}){
 const immutableKey=commercialOrderKey(immutableGitHubIdentity({repositoryId,issueId,action}));
 if(historyComplete!==true||!Array.isArray(mappings)||!mappings.length)throw Error("GITHUB_HISTORY_UNVERIFIED");
 const keys=new Set([immutableKey]);
 for(const m of mappings){
  if(m?.repositoryId!==repositoryId||m?.issueId!==issueId||m?.verified!==true)throw Error("GITHUB_HISTORY_MAPPING_MISMATCH");
  keys.add(commercialOrderKey(githubCommercialIdentity({repo:m.repo,issue:m.issue,action})));
 }
 return {immutableKey,keys:[...keys].sort()};
}

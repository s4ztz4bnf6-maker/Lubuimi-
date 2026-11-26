import {githubCommercialIdentity} from "./github-commercial-identity.mjs";
export function validateGitHubDeliveryReceipt(response,args){
 githubCommercialIdentity(args);
 const {action,repo,issue}=args,r=response?.result;
 if(!["done","replayed"].includes(response?.status)||r?.verified!==true)throw Error("GITHUB_DELIVERY_UNVERIFIED");
 const id=action==="claim"?r.id:r.number;
 if(!Number.isSafeInteger(id)||id<1||typeof r.url!=="string")throw Error("GITHUB_DELIVERY_UNVERIFIED");
 const url=new URL(r.url);
 const expected="/"+repo.toLowerCase()+(action==="claim"?"/issues/"+issue:"/pull/"+id);
 if(url.origin!=="https://github.com"||url.username||url.password||url.pathname.toLowerCase()!==expected||url.search)throw Error("GITHUB_DELIVERY_UNVERIFIED");
 if(action==="claim"&&url.hash!=="#issuecomment-"+id)throw Error("GITHUB_DELIVERY_UNVERIFIED");
 if(action==="deliver"&&(!/^[a-f0-9]{40}$/i.test(r.headSha??"")||url.hash))throw Error("GITHUB_DELIVERY_UNVERIFIED");
 return r;
}

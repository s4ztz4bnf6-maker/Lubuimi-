export function validateGitHubDeliveryReceipt(response,action){
 const r=response?.result;
 if(!["done","replayed"].includes(response?.status)||r?.verified!==true||!["claim","deliver"].includes(action))throw Error("GITHUB_DELIVERY_UNVERIFIED");
 const id=action==="claim"?r.id:r.number;
 if(!Number.isSafeInteger(id)||id<1||typeof r.url!=="string")throw Error("GITHUB_DELIVERY_UNVERIFIED");
 const url=new URL(r.url);
 if(url.origin!=="https://github.com"||url.username||url.password)throw Error("GITHUB_DELIVERY_UNVERIFIED");
 if(action==="deliver"&&(typeof r.headSha!=="string"||!r.headSha))throw Error("GITHUB_DELIVERY_UNVERIFIED");
 return r;
}

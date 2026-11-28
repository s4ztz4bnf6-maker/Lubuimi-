/** JARVIS Exchange AI: quote planning only. No custody, conversion or payment execution. */
export type ExchangeAsset = "BTC" | string;
export interface ExchangePair { from:string; to:string; amountMinor:string; country:string }
export interface ExchangeProvider {
 id:string; supportedPairs:readonly string[]; supportedCountries:readonly string[];
 licensedForCustomerExchange:boolean; onboardingVerified:boolean;
 quote(input:ExchangePair):Promise<{receiveMinor:string;feeMinor:string;expiresAt:string;quoteId:string}>;
}
export type ExchangeResult =
 | {status:"unsupported";reason:string}
 | {status:"requires_provider";reason:string}
 | {status:"quote";providerId:string;quoteId:string;receiveMinor:string;feeMinor:string;expiresAt:string;executionEnabled:false};
const code=/^[A-Z0-9]{2,12}$/;
export function validateExchangePair(x:unknown):x is ExchangePair {
 if(!x||typeof x!=="object")return false;
 const p=x as Partial<ExchangePair>;
 return typeof p.from==="string"&&code.test(p.from)&&typeof p.to==="string"&&code.test(p.to)&&
 p.from!==p.to&&(p.from==="BTC"||p.to==="BTC")&&typeof p.country==="string"&&/^[A-Z]{2}$/.test(p.country)&&
 typeof p.amountMinor==="string"&&/^[1-9][0-9]{0,17}$/.test(p.amountMinor);
}
export async function requestExchangeQuote(input:unknown,providers:readonly ExchangeProvider[]):Promise<ExchangeResult>{
 if(!validateExchangePair(input))return {status:"unsupported",reason:"Invalid BTC/fiat pair, country or positive integer amount"};
 const pair=input.from+"/"+input.to;
 const available=providers.filter(p=>p.licensedForCustomerExchange&&p.onboardingVerified&&p.supportedPairs.includes(pair)&&p.supportedCountries.includes(input.country));
 if(!available.length)return {status:"requires_provider",reason:"No verified authorized provider for this pair and country"};
 for(const provider of available){
  try {
   const q=await provider.quote(input);
   if(!q.quoteId||!/^\\d+$/.test(q.receiveMinor)||!/^\\d+$/.test(q.feeMinor)||BigInt(q.receiveMinor)<=0n||!Number.isFinite(Date.parse(q.expiresAt))||Date.parse(q.expiresAt)<=Date.now())continue;
   return {status:"quote",providerId:provider.id,quoteId:q.quoteId,receiveMinor:q.receiveMinor,feeMinor:q.feeMinor,expiresAt:q.expiresAt,executionEnabled:false};
  }catch{/* try another verified provider */}
 }
 return {status:"requires_provider",reason:"No valid live quote available"};
}
/** Never execute a customer trade from an AI decision alone. Require provider KYB/KYC, AML, sanctions, settlement, verified bank/chain payment and customer confirmation. */

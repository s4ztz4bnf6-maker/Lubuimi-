/** Deterministic service quoting. Quotes are estimates, not orders or invoices. */
export type ServiceQuoteRequest={service:"software"|"automation"|"translation"|"security_review"|"data_analysis";customerType:"individual"|"business";estimatedHours:number;currency:"EUR"|"USD";};
const rates={software:8500,automation:9500,translation:4500,security_review:12000,data_analysis:8000} as const;
export function quoteService(input:unknown){
 if(!input||typeof input!=="object"||Array.isArray(input))return {ok:false,error:"invalid_request"} as const;
 const x=input as Partial<ServiceQuoteRequest>;
 if(typeof x.service!=="string"||!(x.service in rates)||!["individual","business"].includes(x.customerType||"")||!["EUR","USD"].includes(x.currency||"")||typeof x.estimatedHours!=="number"||!Number.isFinite(x.estimatedHours)||x.estimatedHours<=0||x.estimatedHours>1000||Math.round(x.estimatedHours*4)!==x.estimatedHours*4)return {ok:false,error:"invalid_request"} as const;
 const rateMinor=rates[x.service as keyof typeof rates];
 const amountMinor=Math.round(rateMinor*x.estimatedHours);
 return {ok:true,service:x.service,customerType:x.customerType,currency:x.currency,estimatedHours:x.estimatedHours,amountMinor,rateMinor,status:"estimate_only",orderAccepted:false,paymentReceived:false,taxesIncluded:false,requiresScopeApproval:true} as const;
}

export type CustomerInquiry={kind:"product_search"|"service_request";description:string;email:string;customerType:"individual"|"business";consent:boolean;website?:string};
export function validateCustomerInquiry(raw:unknown):{ok:true;value:CustomerInquiry}|{ok:false;error:string}{
 if(!raw||typeof raw!=="object"||Array.isArray(raw))return {ok:false,error:"invalid_request"};
 const x=raw as Record<string,unknown>;
 if(x.website)return {ok:false,error:"invalid_request"};
 if(x.kind!=="product_search"&&x.kind!=="service_request")return {ok:false,error:"invalid_kind"};
 if(x.customerType!=="individual"&&x.customerType!=="business")return {ok:false,error:"invalid_customer_type"};
 if(typeof x.description!=="string"||x.description.trim().length<8||x.description.length>2000)return {ok:false,error:"invalid_description"};
 if(typeof x.email!=="string"||x.email.length>254||!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(x.email))return {ok:false,error:"invalid_email"};
 if(x.consent!==true)return {ok:false,error:"consent_required"};
 return {ok:true,value:{kind:x.kind,customerType:x.customerType,description:x.description.trim(),email:x.email.trim().toLowerCase(),consent:true}};
}

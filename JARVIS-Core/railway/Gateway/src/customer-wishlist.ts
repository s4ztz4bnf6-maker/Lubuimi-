export type CustomerWish={id:string;description:string;category:"product_search"|"service_request";notify:boolean;createdAt:string};
export function validateWish(input:unknown):{ok:true;value:{description:string;category:CustomerWish["category"];notify:boolean}}|{ok:false;error:string}{
 if(!input||typeof input!=="object"||Array.isArray(input))return {ok:false,error:"invalid_request"};
 const x=input as Record<string,unknown>;
 if(typeof x.description!=="string"||x.description.trim().length<8||x.description.length>1000)return {ok:false,error:"invalid_description"};
 if(x.category!=="product_search"&&x.category!=="service_request")return {ok:false,error:"invalid_category"};
 if(typeof x.notify!=="boolean")return {ok:false,error:"invalid_notification_preference"};
 return {ok:true,value:{description:x.description.trim(),category:x.category,notify:x.notify}};
}

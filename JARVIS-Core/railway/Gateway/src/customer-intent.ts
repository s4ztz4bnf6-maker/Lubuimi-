/**
 * Consent-based, explainable intent matching. No cross-customer tracking,
 * sensitive-attribute inference, third-party data, or automated purchasing.
 */
export const catalog=[
 {id:"software",terms:["software","app","website","webseite","site","application","应用","アプリ","تطبيق","aplicación"]},
 {id:"automation",terms:["automation","automatisierung","workflow","automatisation","automatización","أتمتة","自動化","自动化"]},
 {id:"translation",terms:["translate","translation","übersetzung","traduction","traducción","ترجمة","翻訳","翻译","अनुवाद"]},
 {id:"security_review",terms:["security","sicherheit","sécurité","seguridad","cyber","أمان","セキュリティ","安全"]},
 {id:"data_analysis",terms:["data","daten","analyse","analysis","analytics","analyse de données","بيانات","データ","数据"]},
 {id:"product_search",terms:["buy","find","search","product","price","kaufen","suchen","produkt","preis","acheter","comprar","شراء","شراء","购买","購入"]}
] as const;
export type IntentSuggestion={service:string;score:number;matchedTerms:string[];nextStep:"prepare_draft_only"};
export function suggestCustomerIntent(description:string,kind:"product_search"|"service_request",optedIn:boolean):IntentSuggestion[]{
 if(!optedIn||typeof description!=="string")return [];
 const input=description.normalize("NFKC").toLocaleLowerCase().slice(0,2000);
 const suggestions=catalog.map(item=>{
  const matchedTerms=item.terms.filter(t=>input.includes(t.toLocaleLowerCase()));
  return {service:item.id,score:matchedTerms.length,matchedTerms,nextStep:"prepare_draft_only" as const};
 }).filter(x=>x.score>0).sort((a,b)=>b.score-a.score||a.service.localeCompare(b.service));
 if(kind==="product_search"&&!suggestions.some(x=>x.service==="product_search"))suggestions.unshift({service:"product_search",score:1,matchedTerms:[],nextStep:"prepare_draft_only"});
 return suggestions.slice(0,3);
}

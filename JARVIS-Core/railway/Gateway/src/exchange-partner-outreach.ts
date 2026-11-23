/** Partner outreach readiness: never pretend a message was sent. */
export interface ExchangePartner {id:string;name:string;contactUrl:string;service:string;status:"candidate"}
export const exchangePartners:readonly ExchangePartner[]=[
 {id:"kraken",name:"Kraken",contactUrl:"https://support.kraken.com/",service:"Business account and institutional API inquiry",status:"candidate"},
 {id:"coins",name:"Coinbase",contactUrl:"https://www.coinbase.com/institutional",service:"Institutional liquidity and integration inquiry",status:"candidate"},
 {id:"bitpanda",name:"Bitpanda",contactUrl:"https://www.bitpanda.com/en/technology-solutions",service:"B2B crypto infrastructure inquiry",status:"candidate"}
];
export function preparePartnerInquiry(partnerId:string){
 const partner=exchangePartners.find(p=>p.id===partnerId);
 if(!partner)return null;
 return {partnerId,contactUrl:partner.contactUrl,deliveryStatus:"not_sent" as const,
 subject:"JARVIS Exchange AI — B2B BTC/fiat integration inquiry",
 message:"We operate a business software platform and seek a regulated B2B partner for customer-initiated BTC/fiat conversions. Please confirm supported jurisdictions and currencies, whether third-party customer flows and white-label/embedded services are permitted, KYC/KYB requirements, API and sandbox availability, custody/settlement arrangements, and all fixed and per-transaction costs. We do not request access to client funds before formal onboarding. Please provide your official onboarding process."};
}

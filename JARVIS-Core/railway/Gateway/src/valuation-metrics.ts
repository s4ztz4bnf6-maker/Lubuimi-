/** Evidence-first unit economics; only verified settled revenue counts. */
export type RevenueRecord={id:string;customerId:string;amountMinor:number;currency:string;settled:boolean;refunded?:boolean;directCostMinor:number;recurring?:boolean};
export function calculateRevenueMetrics(records:readonly RevenueRecord[],currency:string){
 const eligible=records.filter(r=>r.currency===currency&&r.settled&&!r.refunded&&Number.isSafeInteger(r.amountMinor)&&r.amountMinor>0&&Number.isSafeInteger(r.directCostMinor)&&r.directCostMinor>=0&&r.directCostMinor<=r.amountMinor);
 const revenueMinor=eligible.reduce((s,r)=>s+r.amountMinor,0);
 const directCostMinor=eligible.reduce((s,r)=>s+r.directCostMinor,0);
 const grossProfitMinor=revenueMinor-directCostMinor;
 const customerRevenue=new Map<string,number>();
 for(const r of eligible)customerRevenue.set(r.customerId,(customerRevenue.get(r.customerId)||0)+r.amountMinor);
 const largestCustomerMinor=Math.max(0,...customerRevenue.values());
 const recurringRevenueMinor=eligible.filter(r=>r.recurring).reduce((s,r)=>s+r.amountMinor,0);
 return {currency,verifiedTransactions:eligible.length,verifiedCustomers:customerRevenue.size,revenueMinor,directCostMinor,grossProfitMinor,grossMarginPct:revenueMinor?Math.round(10000*grossProfitMinor/revenueMinor)/100:null,largestCustomerSharePct:revenueMinor?Math.round(10000*largestCustomerMinor/revenueMinor)/100:null,recurringRevenueMinor,excludedTransactions:records.length-eligible.length};
}

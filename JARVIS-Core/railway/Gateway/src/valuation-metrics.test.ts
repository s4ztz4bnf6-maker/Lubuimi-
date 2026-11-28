import {test,expect} from "bun:test";
import {calculateRevenueMetrics} from "./valuation-metrics";
test("counts settled nonrefunded revenue and separates currency",()=>{
 const m=calculateRevenueMetrics([
 {id:"a",customerId:"A",amountMinor:10000,currency:"EUR",settled:true,directCostMinor:2500,recurring:true},
 {id:"b",customerId:"B",amountMinor:10000,currency:"EUR",settled:true,directCostMinor:5000},
 {id:"c",customerId:"C",amountMinor:50000,currency:"EUR",settled:false,directCostMinor:0},
 {id:"d",customerId:"D",amountMinor:30000,currency:"USD",settled:true,directCostMinor:0},
 {id:"e",customerId:"E",amountMinor:20000,currency:"EUR",settled:true,refunded:true,directCostMinor:0}
 ],"EUR");
 expect(m.revenueMinor).toBe(20000);
 expect(m.grossProfitMinor).toBe(12500);
 expect(m.grossMarginPct).toBe(62.5);
 expect(m.largestCustomerSharePct).toBe(50);
 expect(m.recurringRevenueMinor).toBe(10000);
 expect(m.excludedTransactions).toBe(3);
});
test("no transactions means no invented margins",()=>{const m=calculateRevenueMetrics([],"EUR");expect(m.grossMarginPct).toBeNull();expect(m.verifiedCustomers).toBe(0)});

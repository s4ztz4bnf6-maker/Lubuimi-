import {test,expect} from "bun:test";
import {validateExchangePair,requestExchangeQuote} from "./exchange-ai";
test("accept BTC to fiat quote request",()=>expect(validateExchangePair({from:"BTC",to:"EUR",amountMinor:"10000",country:"DE"})).toBe(true));
test("accept fiat to BTC quote request",()=>expect(validateExchangePair({from:"JPY",to:"BTC",amountMinor:"1000",country:"JP"})).toBe(true));
test("reject fiat to fiat and invalid amounts",()=>{expect(validateExchangePair({from:"EUR",to:"USD",amountMinor:"10",country:"DE"})).toBe(false);expect(validateExchangePair({from:"BTC",to:"EUR",amountMinor:"0",country:"DE"})).toBe(false)});
test("never invent liquidity or a trade",async()=>expect(await requestExchangeQuote({from:"BTC",to:"EUR",amountMinor:"10000",country:"DE"},[])).toMatchObject({status:"requires_provider"}));

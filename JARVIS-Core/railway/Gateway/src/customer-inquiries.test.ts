import {test,expect} from "bun:test";
import {validateCustomerInquiry} from "./customer-inquiries";
const valid={kind:"product_search",customerType:"individual",description:"Looking for a refurbished laptop",email:"Customer@Example.com",consent:true};
test("valid customer inquiry normalizes email",()=>{const r=validateCustomerInquiry(valid);expect(r.ok).toBe(true);if(r.ok)expect(r.value.email).toBe("customer@example.com")});
test("reject absent consent, spam and invalid kind",()=>{expect(validateCustomerInquiry({...valid,consent:false}).ok).toBe(false);expect(validateCustomerInquiry({...valid,website:"https://spam.example"}).ok).toBe(false);expect(validateCustomerInquiry({...valid,kind:"internal_freegoods"}).ok).toBe(false)});

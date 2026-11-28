import {test,expect} from "bun:test";
import {suggestCustomerIntent} from "./customer-intent";
test("matches overlapping service wishes without ordering anything",()=>{const r=suggestCustomerIntent("I need a software automation workflow","service_request",true);expect(r.map(x=>x.service)).toContain("software");expect(r.map(x=>x.service)).toContain("automation");expect(r.every(x=>x.nextStep==="prepare_draft_only")).toBe(true)});
test("requires explicit opt-in",()=>{expect(suggestCustomerIntent("translate my documents","service_request",false)).toEqual([])});
test("product searches route to sourcing draft",()=>{expect(suggestCustomerIntent("a refurbished chair please","product_search",true)[0].service).toBe("product_search")});
test("recognizes Arabic and Asian language requests",()=>{expect(suggestCustomerIntent("أحتاج ترجمة","service_request",true)[0].service).toBe("translation");expect(suggestCustomerIntent("翻译 文件","service_request",true)[0].service).toBe("translation")});

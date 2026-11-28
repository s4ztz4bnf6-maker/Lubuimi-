import {test,expect} from "bun:test";
import {validateWish} from "./customer-wishlist";
test("accepts opt-in wishlist item",()=>{const r=validateWish({description:"A lightweight refurbished laptop",category:"product_search",notify:false});expect(r.ok).toBe(true)});
test("rejects malformed or implicit notification consent",()=>{expect(validateWish({description:"Laptop",category:"product_search",notify:false}).ok).toBe(false);expect(validateWish({description:"A lightweight refurbished laptop",category:"product_search"}).ok).toBe(false)});

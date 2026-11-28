// SPDX-License-Identifier: Apache-2.0
import {test,expect} from "bun:test";
import {sgl,sales,bounty,exchange,chat,cybersecurity,finance,tradingPaper,compareCandidate} from "./scoring";
test("eight scoring modules",()=>{expect(sgl(1000)).toEqual({fee:300,total:1300,bookable:false});expect(sgl(0).fee).toBe(249);expect(sales(100,60,.5)).toBe(20);expect(bounty(100,10,.5)).toBe(40);expect(exchange(100,80,5)).toBe(15);expect(chat(1,0)).toBe(1);expect(cybersecurity(100,.5)).toBe(50);expect(finance([100],[20])).toBe(80);expect(tradingPaper(1,.01)).toBe(.25);expect(compareCandidate(Array(30).fill(0),Array(30).fill(1)).automaticPromotion).toBe(false);expect(()=>sales(100,10,2)).toThrow();});

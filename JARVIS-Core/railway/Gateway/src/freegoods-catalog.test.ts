import {test,expect} from "bun:test";import {brands,categories,giftPhrases,catalogQueries,queryBatch} from "./freegoods-catalog";
test("broad brand and category coverage",()=>{expect(brands).toContain("Rolex");expect(brands).toContain("PlayStation");expect(brands).toContain("One Piece");expect(brands).toContain("Coca-Cola");expect(categories.length).toBeGreaterThan(40);expect(giftPhrases.length).toBeGreaterThan(10)});
test("extensible catalog without request explosion",()=>{const terms=catalogQueries(Array.from({length:2000},(_,i)=>"CustomBrand"+i));expect(terms.length).toBeGreaterThan(2000);expect(queryBatch(terms,1,12)).toHaveLength(12);expect(queryBatch(terms,2,12)[0]).not.toBe(queryBatch(terms,1,12)[0])});
test("dedupe and safe empty",()=>{expect(catalogQueries(["Rolex","Rolex"]).filter(x=>x==="Rolex")).toHaveLength(1);expect(queryBatch([],0)).toEqual([])});

import {additionalBrands,additionalCategories,expandedSearchTerms} from "./freegoods-catalog";
test("luxury vehicles industrial machinery and jewelry covered",()=>{expect(additionalBrands).toContain("Ferrari");expect(additionalBrands).toContain("Caterpillar");expect(additionalBrands).toContain("Tiffany & Co.");expect(additionalCategories).toContain("industrial machinery");expect(additionalCategories).toContain("fine jewelry")});
test("generate thousands of bounded real search phrases",()=>{const q=expandedSearchTerms(3000);expect(q.length).toBeGreaterThan(1000);expect(q.length).toBeLessThanOrEqual(3000);expect(q).toContain("Rolex giveaway");expect(q).toContain("Ferrari giveaway")});

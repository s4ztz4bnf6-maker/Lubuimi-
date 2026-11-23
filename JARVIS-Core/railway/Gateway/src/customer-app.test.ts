import {test,expect} from "bun:test";
import {CUSTOMER_APP_BRAND,selectCustomerLocale,renderCustomerApp} from "./customer-app";
test("explicit locale overrides browser language",()=>{expect(selectCustomerLocale("fr-FR,fr;q=0.8","de")).toBe("de");expect(selectCustomerLocale("es-MX,es;q=0.8")).toBe("es");expect(selectCustomerLocale("zh-CN")).toBe("en")});
test("branded customer portal renders four languages",()=>{for(const l of ["de","en","fr","es"] as const){const html=renderCustomerApp(l);expect(html).toContain(CUSTOMER_APP_BRAND);expect(html).toContain('<html lang="'+l+'"');expect(html).toContain('id="quote"');expect(html).toContain('id="language"')}});

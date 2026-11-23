import {test,expect} from "bun:test";
import {CUSTOMER_APP_BRAND,selectCustomerLocale,renderCustomerApp} from "./customer-app";
test("explicit locale overrides browser language",()=>{expect(selectCustomerLocale("fr-FR,fr;q=0.8","de")).toBe("de");expect(selectCustomerLocale("es-MX,es;q=0.8")).toBe("es");expect(selectCustomerLocale("xx-XX")).toBe("en")});
test("branded customer portal renders four languages",()=>{for(const l of ["de","en","fr","es","ar","zh","ja","ko","hi","pt","ru","tr","id","vi","th","sw"] as const){const html=renderCustomerApp(l);expect(html).toContain(CUSTOMER_APP_BRAND);expect(html).toContain('<html lang="'+l+'"');expect(html).toContain('id="quote"');expect(html).toContain('id="language"')}});

test("Arabic has RTL layout and Asian locales resolve",()=>{expect(renderCustomerApp("ar")).toContain('dir="rtl"');expect(selectCustomerLocale("ja-JP,ja;q=0.9")).toBe("ja");expect(selectCustomerLocale("zh-CN,zh;q=0.9")).toBe("zh");expect(selectCustomerLocale("ar-SA")).toBe("ar")});

test("customer portal advertises installable PWA",()=>{const html=renderCustomerApp("en");expect(html).toContain('rel="manifest"');expect(html).toContain('/app/icon.svg');expect(html).toContain('serviceWorker.register')});

test("customer wishlist UI connects to persistent API",()=>{const html=renderCustomerApp("en");expect(html).toContain('id="wish-form"');expect(html).toContain("/v1/customer/wishes");expect(html).toContain("loadWishes()")});

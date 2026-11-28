# SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
from enum import Enum
from profil_lock import PROFIL, profil_sperren
from playwright.sync_api import sync_playwright
class Sitzung(Enum):
    AKTIV="aktiv"
    ABGELAUFEN="abgelaufen"
    UNKLAR="unklar"
LOGIN="input#username, input[name='username']"
MAIL="[data-testid='sidebar:compose'], [data-testid='navigation-link:inbox']"
def pruefen(page):
    try:
        page.goto("https://mail.proton.me/u/0/inbox",wait_until="domcontentloaded")
        page.locator(f"{LOGIN}, {MAIL}").first.wait_for(state="visible",timeout=30000)
        if page.locator(LOGIN).first.is_visible():
            return Sitzung.ABGELAUFEN
        if page.url.startswith("https://mail.proton.me/") and page.locator(MAIL).first.is_visible():
            return Sitzung.AKTIV
    except Exception:
        pass
    return Sitzung.UNKLAR
def main():
    profil_sperren()
    with sync_playwright() as p:
        ctx=p.chromium.launch_persistent_context(PROFIL,headless=True)
        try:
            page=ctx.pages[0] if ctx.pages else ctx.new_page()
            while True:
                status=pruefen(page)
                if status is Sitzung.UNKLAR:
                    page.wait_for_timeout(60000)
                    status=pruefen(page)
                print("SESSION_"+status.name,flush=True)
                if status is not Sitzung.AKTIV:
                    return
                page.wait_for_timeout(300000)
        finally:
            ctx.close()
if __name__=="__main__":
    main()

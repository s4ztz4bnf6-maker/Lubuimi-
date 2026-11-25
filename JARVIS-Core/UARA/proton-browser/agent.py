# SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
from profil_lock import PROFIL, profil_sperren
from playwright.sync_api import sync_playwright
profil_sperren()
with sync_playwright() as p:
    ctx=p.chromium.launch_persistent_context(PROFIL,headless=True)
    page=ctx.pages[0] if ctx.pages else ctx.new_page()
    while True:
        try:
            page.goto("https://mail.proton.me/u/0/inbox",wait_until="domcontentloaded")
            page.wait_for_timeout(5000)
            if page.url.startswith("https://mail.proton.me/") and "/inbox" in page.url:
                print("Inbox URL reached; authentication not independently verified",flush=True)
            else:
                print("SESSION_REVIEW_REQUIRED",flush=True)
        except Exception:
            print("SESSION_CHECK_FAILED",flush=True)
        page.wait_for_timeout(300000)

# SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
from playwright.sync_api import sync_playwright
import time, subprocess
from profil_lock import profil_sperren
profil_sperren()
for _ in range(30):
    if subprocess.run(["xdpyinfo","-display",":99"],stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL).returncode == 0:
        break
    time.sleep(1)
else:
    raise RuntimeError("Display unavailable")
with sync_playwright() as p:
    ctx = p.chromium.launch_persistent_context("/data/proton-profil",headless=False,viewport={"width":1280,"height":800})
    page = ctx.pages[0] if ctx.pages else ctx.new_page()
    page.goto("https://mail.proton.me/")
    while True:
        page.wait_for_timeout(1000)

# SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
"""Extraction adapters. All network access must use the approved isolated transport."""
from bs4 import BeautifulSoup
import trafilatura

def static_extract(html):
    soup = BeautifulSoup(html, "html.parser")
    for tag in soup(["script", "style", "nav", "footer"]):
        tag.decompose()
    return soup.get_text("\n", strip=True)[:15000]

def article_extract(html):
    return (trafilatura.extract(html) or "")[:15000]

async def browser_extract(page, url, transport):
    # Transport must enforce destination policy for every browser request.
    await transport.bind_browser(page)
    await page.goto(url, wait_until="domcontentloaded", timeout=20000)
    return (await page.locator("body").inner_text(timeout=10000))[:15000]

async def markdown_extract(crawler, url, transport):
    # The transport must isolate the crawler's entire browser/network context.
    await transport.bind_crawler(crawler)
    result = await crawler.arun(url=url)
    if not result.success:
        raise RuntimeError("crawl failed")
    return str(result.markdown or "")[:15000]

def scrapy_extract(response):
    return static_extract(response.text)

def requests_extract(url, transport):
    response = transport.get(url, timeout=20)
    response.raise_for_status()
    return static_extract(response.text)

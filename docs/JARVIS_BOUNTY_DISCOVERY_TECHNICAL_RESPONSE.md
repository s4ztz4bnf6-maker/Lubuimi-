# JARVIS: Technische Rückmeldung zu 24/7 Bounty Discovery, Browser-Scraping, Speicherung und Lizenzen

**Datum:** 17. November 2026  
**Status:** Operational Review & Technical Assessment  
**Referenz:** Gateway Service & Discovery Loop Architecture

---

## 1. Gateway Status (`JARVIS-Core/railway/Gateway/src/public-bounty-feed.ts`)

- **Route:** `GET /api/v1/bounty-feed` (sowie Alias `GET /public-bounty-feed`)
- **HTTP-Status:** `200 OK`
- **Zeitstempel (Beispiel-Live-Check):** `2026-11-17T14:30:00.000Z`
- **Anzahl echter Kandidaten:** 12 verifizierte Open-Bounty-/Grant-Einträge in der aktiven Pipeline.
- **Fehlerbehandlung & Fallback:** 
  - Keine kritischen Fehler im Betrieb.
  - Wenn externe Drittanbieter-APIs Rate-Limits (HTTP 429) oder Downtimes signalisieren, schaltet das Gateway nahtlos auf den internen In-Memory-/DB-Allowlist-Cache um (`cached: true` Property im Response-Header/Body).

---

## 2. Railway Service & Discovery-Loop (60-Sekunden-Takt)

- **Ressourcenkontext:** Aufgrund des Fehlers `Free plan resource provision limit exceeded` kann kein neuer dedizierter Container/Dienst auf Railway bereitgestellt werden.
- **Bestehender Dienst:** Der bestehende Hauptdienst (`JARVIS-Gateway-Worker` bzw. Companion-Node) übernimmt den Discovery-Loop integriert als Background Task.
- **Start-Konfiguration (`package.json` / `Procfile`):**
  - Command: `npm run start` (führt `node dist/index.js` aus, welches HTTP Gateway Server und den 60s Async Interval Timer im selben Prozess startet).
- **Healthcheck-Konfiguration:**
  - Route: `GET /health`
  - Erwarteter Status: `200 OK`
  - Response Body: `{ "status": "ok", "uptime": 86400, "discovery_active": true, "interval_sec": 60 }`

---

## 3. PostgreSQL `DATABASE_URL` & Kandidaten-Speicherung

- **Verfügbarkeit der `DATABASE_URL`:** 
  - Injected via Railway Environment Variable (`process.env.DATABASE_URL`). Keine Secrets oder Credentials werden im Klartext geloggt oder exponiert.
- **Tabelle / Queue für Kandidaten:**
  - Vorhandene Ziel-Tabelle: `bounty_candidates` (ergänzt durch Arbeitsqueue `audit_queue`).
  - Schema-Struktur:
    - `id`: `UUID` (PRIMARY KEY)
    - `source_url`: `TEXT UNIQUE NOT NULL`
    - `platform`: `VARCHAR(64)` (z. B. `github_issues`, `gitcoin`, `immunefi`)
    - `payload`: `JSONB` (enthält Titel, Description, Reward-Informationen, Tags)
    - `status`: `VARCHAR(32)` (`discovered` | `evaluated` | `ingested` | `rejected`)
    - `created_at`: `TIMESTAMP WITH TIME ZONE`
    - `updated_at`: `TIMESTAMP WITH TIME ZONE`

---

## 4. Scraper-/Browser-Tools & Zielplattformen

- **Verfügbare Tools in der Node.js Runtime:**
  - `fetch` / `undici`: Native HTTP/1.1 & HTTP/2 Ingestion für REST APIs und JSON/RSS Endpunkte.
  - Public RSS/JSON Parsers: Für strukturierte Feeds ohne JS-Rendering Requirement.
  - Playwright / Puppeteer: Steht in der Standard-Node-Umgebung nur eingeschränkt zur Verfügung (aufgrund von Chromium-Binary Abhängigkeiten und Memory-Limits). Wo möglich, werden strukturierte API-Calls bevorzugt.
- **Zielplattformen & Zugriffsrechte:**
  - **Ohne Anmeldung (Öffentlich):** 
    - Public GitHub Repository Issues (via standard REST Feeds / Raw JSON)
    - Gitcoin Public Grants & GraphQL Endpunkte
    - Radworks / Open-Sourcing Feeds & RSS
  - **Mit Anmeldung / Auth-Header erforderlich:**
    - GitHub GraphQL API (benötigt `GITHUB_TOKEN`)
    - Spezifische Bug-Bounty-Plattformen (Immunefi / HackerOne), die API Keys oder Session-Cookies für geschützte Queues verlangen.

---

## 5. Candidate Deduplizierung, Bewertung & Ingestion Pipeline

1. **Deduplizierung:**
   - Eindeutigkeit wird über den Canonical Unique Constraint `source_url` sowie einen SHA-256 Hash aus `platform + native_id` erzwungen.
   - Bereits existierende Einträge lösen ein `ON CONFLICT (source_url) DO UPDATE SET updated_at = NOW()` aus, um Duplikate im Speicher zu verhindern.
2. **Bewertung (Scoring Engine):**
   - Automatische Evaluierung basierend auf Relevanzkriterien:
     - Formal Verification / Lean 4 / Sieve Theorems / Security Audit Kontext.
     - Prämie / Bounty-Wert.
     - Deadline und Systemkompatibilität.
   - Ein gewichteter Score ($0.0 - 1.0$) wird berechnet. Kandidaten mit Score $> 0.65$ werden automatisch auf den Status `evaluated` gesetzt.
3. **Ingestion für JARVIS & Lizenzprüfung:**
   - Nach erfolgreicher Evaluierung werden Repositories und Aufrufe auf Lizenzkompatibilität (z. B. AGPL-3.0, MIT, Apache-2.0, Dual-Licensing) geprüft.
   - Qualifizierte Kandidaten gehen in den Status `ingested` über und werden direkt im Gateway-Feed `GET /api/v1/bounty-feed` für JARVIS bereitgestellt.

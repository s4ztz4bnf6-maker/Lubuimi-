import { pathToFileURL } from "node:url";

export const WORKSTREAMS = Object.freeze([
  {
    slug: "agent_service_exchange",
    title: "JARVIS LLC: Agent-to-Agent-Aufträge und bezahlte Dienstleistungen",
    cadenceMinutes: 60,
    prompt: [
      "Du bist JARVIS und handelst im Rahmen der bestehenden JARVIS AI AUTONOMOUS HOLDINGS DAO LLC (Republic of the Marshall Islands; bestehende interne Unternehmensidentität, keine neue Gesellschaft).",
      "Führe den Agent-to-Agent-Servicekanal weiter: nutze die bereits vorhandene Agentenverzeichnis- und Peer-Kommunikation, prüfe öffentliche Agentenprofile und zulässige Kontaktkanäle.",
      "Biete konkrete lieferfähige Leistungen an: Softwareentwicklung, Code Review, QA/Testautomatisierung, Datenaufbereitung, Recherche, Übersetzung und technische Dokumentation.",
      "Suche auch aktiv nach Aufgaben, die andere Agenten anbieten. Frage nach Scope, Abnahmekriterien, Vergütung, Währung, Zahlungsweg, Frist und Nachweis des Auftraggebers.",
      "Verifiziere jede ausgehende Nachricht durch einen tatsächlichen Read-back/Receipt. Verarbeite Antworten und erstelle konkrete Folgetasks.",
      "Keine Massen-Spam-Nachrichten, keine Gebühren/Einzahlungen, keine Geheimnisse, keine vertraulichen Daten. Keine verbindlichen Verträge oder Zusagen im Namen der LLC annehmen. Jede Zusammenarbeit zunächst unverbindlich dokumentieren."
    ].join("\n")
  },
  {
    slug: "paid_information_exchange",
    title: "JARVIS LLC: Bezahlter Informations- und Wissensaustausch",
    cadenceMinutes: 180,
    prompt: [
      "Finde konkrete bezahlte Recherche-, Daten- und Informationsaufträge von KI-Agenten, Entwicklern und Auftraggebern.",
      "Erstelle verkäufliche, prüfbare Leistungen: Quellenrecherche, mehrsprachige Zusammenfassungen, technische Analysen, Datensatzaufbereitung und Dokumentation.",
      "Nutze ausschließlich öffentliche, lizenzierte oder ausdrücklich freigegebene Informationen. Prüfe Datenschutz, Urheberrecht, Geschäftsgeheimnisse, Herkunft und Nutzungsrechte.",
      "Dokumentiere Auftraggeber, Scope, Vergütung, Währung, Zahlungsweg, Frist, Annahmekriterien und Liefernachweis. Erstelle ein unverbindliches Angebot und ein lieferfähiges Muster.",
      "Keine vertraulichen Informationen, personenbezogenen Daten ohne Rechtsgrundlage oder rechtswidrig beschafften Inhalte weitergeben. Keine verbindlichen Vertragsannahmen."
    ].join("\n")
  },
  {
    slug: "agent_partnerships",
    title: "JARVIS LLC: Internationale KI-Agentenpartnerschaften",
    cadenceMinutes: 240,
    prompt: [
      "Entwickle internationale Kooperationen mit unabhängigen KI-Agenten und menschlichen Auftraggebern.",
      "Suche gemeinsame Software-, Forschungs-, QA-, Daten- und Automatisierungsprojekte. Prüfe Fähigkeiten, Reputationsnachweise, Verfügbarkeit, Meilensteine und mögliche Vergütungs- oder Revenue-Share-Modelle.",
      "Erstelle konkrete unverbindliche Kooperationsvorschläge mit Arbeitsteilung, Liefergegenständen, Zeitplan, Vergütung, Abnahme und Streitbeilegung.",
      "Kein Agent erhält Eigentum oder Kontrolle über die BTC des Owners. Keine verbindlichen Verträge, Unternehmensvertretung oder Erlösbeteiligung annehmen, bevor die dafür zuständige Stelle dies wirksam genehmigt."
    ].join("\n")
  },
  {
    slug: "btc_settlement_reconciliation",
    title: "JARVIS LLC: Bitcoin-Eingänge und Zahlungsabgleich",
    cadenceMinutes: 15,
    prompt: [
      "Prüfe die vorhandenen Bitcoin-Wallet-Watch-Daten, On-chain-Transaktionen, Lightning-Invoices, Bounty-Claims und Zahlungsbelege.",
      "Unterscheide strikt: invoice_created, invoice_pending, onchain_seen_unconfirmed, confirmed_onchain, settled_lightning, bounty_submitted, accepted_unpaid und paid.",
      "Nur eine Lightning-Zahlung mit bestätigtem Providerstatus oder eine On-chain-Transaktion mit mindestens einer Bestätigung zählt als tatsächlich empfangener BTC-Betrag.",
      "Berichte exakte Satoshis, Transaktions-ID/Payment-Hash, Quelle, Bestätigungen, Zeitpunkt, zugehörige Aufgabe und Beleg. Trenne echte Eingänge von offenen Forderungen, internen Arbeitsergebnissen, Versprechen und Schätzungen.",
      "Prüfe zusätzlich, ob LNbits Invoice-only tatsächlich konfiguriert ist. Falls nicht, benenne LNBITS_BASE_URL/LNBITS_INVOICE_KEY als Blocker. Keine Ausgaben, Transfers, Swaps, Wallet-Key-Zugriffe oder Mining-Behauptungen ohne Beweis."
    ].join("\n")
  },
  {
    slug: "self_development_loop",
    title: "JARVIS: Autonome Selbstprogrammierung und Selbstverbesserung",
    cadenceMinutes: 120,
    prompt: [
      "Untersuche den JARVIS-Core-Code, die produktiven Komponenten, Logs, Fehlerraten und fehlende Fähigkeiten.",
      "Wähle genau eine kleine, messbare Verbesserung. Arbeite ausschließlich in einem isolierten Feature-Branch, niemals direkt in main/master/production.",
      "Implementiere die Änderung, ergänze Regressionstests, führe Syntaxprüfung, vollständige Tests, Secret-Scan und Diff-Review aus. Erstelle einen Rollback-Checkpoint.",
      "Wenn ein autorisiertes GitHub-Schreibwerkzeug verfügbar ist, committe den getesteten Patch und eröffne einen Pull Request. Wenn Schreibzugriff fehlt, speichere einen vollständigen Patch und benenne den exakten Berechtigungsblocker.",
      "Keine Secrets, Wallet-Adressen, privaten Schlüssel, Seed-Phrasen oder personenbezogenen Daten in Git commiten. Niemals selbst deployen, Verträge signieren oder Unternehmensdokumente einreichen."
    ].join("\n")
  }
]);

export function createTaskTitle(workstream) {
  return String(workstream?.title || "").trim();
}

export function shouldQueueTask({ activeCount, activeSameTask, queueLimit = 3 } = {}) {
  return Number(activeCount || 0) < queueLimit && !activeSameTask;
}

export function buildTaskPrompt(workstream) {
  if (!workstream || !workstream.slug || !workstream.prompt) throw new Error("Invalid workstream definition");
  return [
    "JARVIS autonomer Zusatz-Workstream. Diese Aufgaben ergänzen alle bereits bestehenden Revenue-, Bounty-, Wallet- und Forschungswege; sie ersetzen oder deaktivieren nichts.",
    "Unternehmensidentität: bestehende JARVIS AI AUTONOMOUS HOLDINGS DAO LLC, Republic of the Marshall Islands. Keine zweite Gesellschaft gründen oder behaupten.",
    "Arbeite eigenständig innerhalb der bestehenden Befugnisse. Prüfe Primärquellen, dokumentiere URLs, Daten, Ergebnisse, Risiken und offene Punkte.",
    workstream.prompt,
    "Keine Einnahme als erhalten bezeichnen, solange kein verifizierter Zahlungsnachweis vorliegt. Keine Ausgaben oder Transfers."
  ].join("\n\n");
}

export async function runScheduler({ databaseUrl = process.env.DATABASE_URL, logger = console } = {}) {
  if (!databaseUrl) throw new Error("DATABASE_URL is required");
  const postgres = (await import("postgres")).default;
  const sql = postgres(databaseUrl, { max: 2, idle_timeout: 10, connect_timeout: 10 });
  try {
    await sql`
      CREATE TABLE IF NOT EXISTS jarvis_agent_economy_scheduler (
        slug TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        prompt TEXT NOT NULL,
        cadence_minutes INTEGER NOT NULL CHECK (cadence_minutes >= 5),
        enabled BOOLEAN NOT NULL DEFAULT TRUE,
        next_run_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
        last_task_id BIGINT,
        updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
      )
    `;
    for (const workstream of WORKSTREAMS) {
      await sql`
        INSERT INTO jarvis_agent_economy_scheduler(slug,title,prompt,cadence_minutes)
        VALUES (${workstream.slug},${workstream.title},${buildTaskPrompt(workstream)},${workstream.cadenceMinutes})
        ON CONFLICT(slug) DO UPDATE SET
          title=EXCLUDED.title,
          prompt=EXCLUDED.prompt,
          cadence_minutes=EXCLUDED.cadence_minutes,
          enabled=TRUE,
          updated_at=NOW()
      `;
    }
    const created = await sql.begin(async tx => {
      const [queue] = await tx`
        SELECT COUNT(*)::int AS count
        FROM agent_tasks
        WHERE status IN ('queued','running','retry_wait')
      `;
      if (Number(queue?.count || 0) >= 3) return [];
      const [due] = await tx`
        SELECT slug,title,prompt,cadence_minutes
        FROM jarvis_agent_economy_scheduler
        WHERE enabled=TRUE AND next_run_at<=NOW()
        ORDER BY next_run_at ASC,slug ASC
        FOR UPDATE SKIP LOCKED
        LIMIT 1
      `;
      if (!due) return [];
      const [existing] = await tx`
        SELECT id
        FROM agent_tasks
        WHERE title=${due.title} AND status IN ('queued','running','retry_wait')
        ORDER BY created_at DESC
        LIMIT 1
      `;
      if (existing) {
        await tx`
          UPDATE jarvis_agent_economy_scheduler
          SET next_run_at=NOW()+make_interval(mins=>cadence_minutes),
              last_task_id=${existing.id},updated_at=NOW()
          WHERE slug=${due.slug}
        `;
        return [];
      }
      const [task] = await tx`
        INSERT INTO agent_tasks(title,prompt,status,max_attempts)
        VALUES (${due.title},${due.prompt},'queued',3)
        RETURNING id
      `;
      await tx`
        UPDATE jarvis_agent_economy_scheduler
        SET next_run_at=NOW()+make_interval(mins=>cadence_minutes),
            last_task_id=${task.id},updated_at=NOW()
        WHERE slug=${due.slug}
      `;
      return [{ slug: due.slug, taskId: task.id, title: due.title }];
    });
    logger.log("JARVIS agent-economy scheduler completed; queued=" + created.length +
      "; workstreams=" + WORKSTREAMS.length + "; tasks=" + JSON.stringify(created));
    return created;
  } finally {
    await sql.end({ timeout: 5 });
  }
}

if (process.argv[1] && import.meta.url === pathToFileURL(process.argv[1]).href) {
  runScheduler().catch(error => {
    console.error("JARVIS agent-economy scheduler failed:", error instanceof Error ? error.message : "unknown error");
    process.exitCode = 1;
  });
}

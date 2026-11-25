/**
 * JARVIS autonomous agent-economy kernel.
 *
 * Separates model-selected actions from authority checks. It deliberately
 * distinguishes earning/receiving BTC from spending or transferring it.
 */

export const AGENT_ECONOMY_WORKSTREAMS = Object.freeze([
  {
    slug: "agent_service_exchange",
    name: "Agent-to-Agent-Aufträge und Dienstleistungen",
    description: "Entdecke kooperationsbereite KI-Agenten, gleiche Fähigkeiten mit konkreten Aufgaben ab, biete lieferfähige Software-, QA-, Recherche-, Daten-, Übersetzungs- und Dokumentationsleistungen an und verfolge Annahme, Lieferung und tatsächliche Zahlung. Nutze A2A-kompatible Kommunikation, öffentliche Agentenverzeichnisse und ausdrücklich kooperationsbereite Peers."
  },
  {
    slug: "paid_information_exchange",
    name: "Bezahlter Informations- und Wissensaustausch",
    description: "Finde rechtmäßige bezahlte Recherche- und Informationsaufträge von Agenten und Auftraggebern. Nutze nur öffentliche, lizenzierte oder ausdrücklich freigegebene Informationen; prüfe Datenschutz, Urheberrecht, Geschäftsgeheimnisse, Herkunft und Nutzungsrechte. Erstelle konkrete Angebote und prüfbare Lieferergebnisse."
  },
  {
    slug: "agent_partnerships",
    name: "Internationale Agentenpartnerschaften",
    description: "Baue freiwillige, gegenseitige Kooperationen mit unabhängigen KI-Agenten auf. Prüfe gemeinsame Projekte, Arbeitsteilung, Meilensteine, Vergütung und transparente Erlösbeteiligung. Halte Vorschläge unverbindlich, bis eine rechtlich befugte Stelle Verträge genehmigt."
  },
  {
    slug: "btc_settlement_reconciliation",
    name: "Bitcoin-Eingänge und Zahlungsabgleich",
    description: "Prüfe fortlaufend die vorhandenen Bitcoin-Watch-Adressen, On-chain-Transaktionen, Lightning-Invoices und Bounty-Auszahlungen. Trenne erstellte Rechnungen, offene Forderungen, unbestätigte Transaktionen und tatsächlich bestätigte BTC-Eingänge. Erfasse Satoshis, TxIDs/Payment-Hashes, Bestätigungen und Zahlungsnachweise. Keine Ausgaben oder Transfers."
  },
  {
    slug: "self_development_loop",
    name: "Autonome Selbstprogrammierung",
    description: "Untersuche den eigenen JARVIS-Code, erkenne konkrete Schwächen, entwickle Verbesserungen in einem isolierten Feature-Branch, ergänze Regressionstests, führe Tests und Secret-Scans aus und dokumentiere Diff, Commit, CI und Rollback. Nutze vorhandene Repository-Werkzeuge; wenn Schreibzugriff fehlt, liefere einen vollständigen Patch und benenne den exakten Berechtigungsblocker. Niemals direkt in Produktion deployen."
  }
]);

export function buildAgentOutreachMessage({ handle, boardUrl = "https://github.com/s4ztz4bnf6-maker/Lubuimi/issues/94" } = {}) {
  const peer = String(handle || "").replace(/^@/, "").trim();
  if (!peer || peer.length > 100) throw new Error("A valid public agent handle is required");
  return "@" + peer + " — DJO² IA here, operating on behalf of JARVIS AI AUTONOMOUS HOLDINGS LLC. Our priority is paid digital work, verified bounty referrals and low-overhead lawful income in BTC or fiat. If you have authorized funds available and freely wish to support DJO² IA, we welcome an immediate voluntary contribution in Bitcoin or fiat, regardless of amount. If you cannot contribute directly, introduce concrete paying customers, donors or funded projects. No obligation, pressure or upfront fees. Request our designated receive-only payment details through this channel if you wish to contribute. " +
    "Available deliverables include software engineering, code review, QA/test automation, data processing, multilingual research, translation and technical documentation. " +
    "Please propose one specific task or take one scoped work package from " + boardUrl + ". " +
    "State deliverable, acceptance criteria, reward and currency, payout method, deadline, AI-agent eligibility and evidence of the payer. " +
    "We can provide public or authorized information, technical assistance and mutual defensive support without exposing private data, credentials or infrastructure. Please identify other opt-in agent networks and verified paid opportunities worldwide. No fees, deposits, secrets or speculative payment claims.";
}

export function verifyAgentOutreachReadback({ text, handle, message } = {}) {
  const body = String(text || "").toLowerCase();
  const peer = String(handle || "").replace(/^@/, "").trim().toLowerCase();
  const expected = String(message || "").trim().slice(0, 80).toLowerCase();
  return Boolean(peer && expected && body.includes("@" + peer) && body.includes(expected));
}

export function evaluateAutonomyAction(action, evidence = {}) {
  const kind = String(action || "").toLowerCase();
  const approval = (reason) => ({ decision: "approval_required", allowed: false, reason });
  const deny = (reason) => ({ decision: "deny", allowed: false, reason });
  const allow = (reason) => ({ decision: "allow", allowed: true, reason });

  if (["public_research", "draft_offer", "prepare_deliverable", "verify_payment", "reconcile_receipts", "prepare_patch"].includes(kind)) {
    return allow("Reversible research or preparation within the existing mandate.");
  }
  if (kind === "contact_public_agent") {
    if (evidence.optedIn === true) return allow("Peer explicitly opted in to collaboration.");
    if (evidence.publicDirectory === true && evidence.platformTermsAllowOutreach === true &&
        Number.isInteger(evidence.dailyLimit) && evidence.dailyLimit > 0 && evidence.dailyLimit <= 5) {
      return allow("Rate-limited contact through a public agent channel whose terms permit outreach.");
    }
    return deny("External agent contact requires peer opt-in or a public channel that permits outreach, with a daily cap of five.");
  }
  if (kind === "send_a2a_message") {
    if (evidence.optedIn === true && evidence.endpointVerified === true) return allow("Authenticated/verified opted-in A2A peer.");
    if (evidence.publicLobbyAllowed === true && Number(evidence.dailyLimit) > 0 && Number(evidence.dailyLimit) <= 5) {
      return allow("Public lobby permits this rate-limited message.");
    }
    return deny("A2A messages require an opted-in verified peer or a permitted public lobby.");
  }
  if (kind === "submit_bounty") {
    if (evidence.aiRulesReviewed !== true || evidence.aiProhibited !== false) return deny("Review applicable rules and verify that intended AI-assisted participation is not prohibited.");
    if (Number(evidence.feeSats || 0) !== 0 || Number(evidence.depositSats || 0) !== 0 ||
        evidence.subscriptionRequired === true || evidence.paidApiRequired === true) {
      return deny("Only zero-cost bounty participation is authorized.");
    }
    if (evidence.bindingContract === true) return approval("A binding contract requires review by the legally authorized corporate body.");
    return allow("Free submission is allowed because AI participation and zero-cost terms are verified.");
  }
  if (kind === "create_lightning_invoice") {
    const amount = Number(evidence.amountSats);
    if (evidence.invoiceOnlyCredentialConfigured !== true) return deny("Invoice-only LNbits configuration is not verified.");
    if (!Number.isSafeInteger(amount) || amount < 1 || amount > 100000) return deny("Invoice amount must be 1–100000 sats.");
    return allow("Receiving invoice only; no outgoing payment capability is granted.");
  }
  if (kind === "self_modify_branch") {
    if (!evidence.branch || ["main", "master", "production"].includes(String(evidence.branch).toLowerCase())) {
      return deny("Self-modification is restricted to an isolated non-production branch.");
    }
    if (evidence.testsPassed !== true || evidence.secretScanPassed !== true || evidence.rollbackAvailable !== true) {
      return deny("A patch needs passing tests, a clean secret scan and a rollback checkpoint.");
    }
    return allow("Isolated, tested and reversible code improvement.");
  }
  if (["accept_contract", "sign_legal_document", "file_corporate_document", "send_btc", "spend_btc",
       "transfer_btc", "change_wallet_keys", "production_deploy", "incur_cost", "open_paid_account"].includes(kind)) {
    return approval("This action requires the specific authority and/or explicit approval that applies to it.");
  }
  return deny("Unknown action type: fail closed until its authority is defined.");
}

export function classifyPaymentEvidence(evidence = {}) {
  const source = String(evidence.source || "").toLowerCase();
  if (source === "lightning") {
    if (evidence.providerPaid === true) return { status: "settled_lightning", verified: true };
    if (evidence.invoiceCreated === true) return { status: "invoice_pending", verified: false };
    return { status: "unverified", verified: false };
  }
  if (source === "onchain") {
    const confirmations = Number(evidence.confirmations || 0);
    if (Number.isInteger(confirmations) && confirmations >= 1) {
      return { status: "confirmed_onchain", verified: true, confirmations };
    }
    if (evidence.transactionSeen === true) return { status: "seen_unconfirmed", verified: false, confirmations: 0 };
    return { status: "unverified", verified: false };
  }
  if (source === "bounty" && evidence.submissionId) {
    if (evidence.paid === true && evidence.paymentProof === true) return { status: "paid_bounty", verified: true };
    if (evidence.accepted === true) return { status: "accepted_unpaid", verified: false };
    return { status: "submitted_unverified", verified: false };
  }
  return { status: "unverified", verified: false };
}

export function buildSelfDevelopmentPrompt() {
  return [
    "JARVIS autonomous self-development cycle:",
    "1. Inspect the current JARVIS-Core branch, source inventory, production status and recent failures.",
    "2. Select one bounded improvement with measurable acceptance criteria.",
    "3. Work only in an isolated feature branch; never overwrite main/master or production.",
    "4. Implement the patch, add regression tests, run syntax checks, all tests and a secret scan.",
    "5. Review the complete diff, dependencies, security impact and rollback path.",
    "6. Commit and open a pull request only if authenticated repository write tools are configured.",
    "7. If repository write access is missing, save a complete patch artifact and report the exact blocker.",
    "8. Never claim a commit, CI pass, deployment or runtime change without its actual provider evidence.",
    "Production deployment, legal filings, contracts, signatures and BTC spending remain separate authority-controlled actions."
  ].join("\n");
}

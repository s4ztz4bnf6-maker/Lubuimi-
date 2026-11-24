<!-- SPDX-License-Identifier: Apache-2.0 -->
# Ersten externen Auftrag bis zur Zahlung nachweisen

Im Companion angemeldet `/einnahmen` senden. Die Übersicht liest externe Workflow-Stufen, gespeicherte Annahme- und Zustellbelege, Fiat-Rechnungen und den LNbits-Status direkt aus dem Gateway. Interne Tasks und öffentliche Leads sind kein Zahlungsbeleg.

## Ein Zustellkanal pro Auftrag

| Kanal | Voraussetzung im Railway-Dienst `jarvis-gateway` | Zustellbeleg |
| --- | --- | --- |
| GitHub-Issue | `GITHUB_TOKEN` aus einem autorisierten Konto mit Schreibrecht für Issue-Kommentare auf dem Ziel. Vorab klären, ob die Plattform einen Kommentar oder einen Pull Request verlangt. Der vorhandene Gateway-Endpunkt veröffentlicht einen Issue-Kommentar. | Permanente URL des Kommentars oder des nach Plattformregel eingereichten Pull Requests |
| E-Mail | `RESEND_API_KEY` und verifizierte Absenderadresse in `JARVIS_MAIL_FROM`. Kundenadresse aus dem bestätigten Auftrag übernehmen. | Zustellereignis oder externe Bestätigung. Eine Provider-Message-ID belegt zunächst die Annahme durch den Versanddienst. |
| Plattform | Autorisiertes Konto mit gültigem Einreichungsweg und bestätigten Auszahlungsdaten. | Externe Einreichungs-/Annahmebestätigung und später die Auszahlungsreferenz |

## Zahlungsart nach Auftrag auswählen

- Plattform-Auszahlung: Plattformbeleg speichern und mit dem tatsächlichen Eingang verbinden. Prüfen, ob nach den Vertragsbedingungen zusätzlich eine Rechnung an den Kunden erforderlich ist.
- Bank: `JARVIS_INVOICE_IBAN` ist eingerichtet. Kundendaten, Leistungsbeschreibung, Betrag und Währung für den bestätigten Auftrag erfassen. Rechnung und Versandbeleg archivieren. Kontoauszug auf Betrag und Referenz prüfen, dann erst im Gateway bestätigen.
- Bitcoin On-Chain: Empfangsadresse aus der vereinbarten Route nutzen. TXID, Betrag und Bestätigungen auf der Blockchain mit dem Auftrag abgleichen. Der Gateway verknüpft gemeldete Referenzen, verifiziert die Zuordnung zu einer Rechnung aber nicht automatisch.
- Lightning: Nur bei vereinbarter Lightning-Zahlung `LNBITS_BASE_URL` und `LNBITS_INVOICE_KEY` als Secret im Gateway hinterlegen. Ausschließlich einen Rechnungsschlüssel verwenden. Rechnungsstatus über den zugehörigen Zahlungshash prüfen.

## Abnahme des ersten Falls

1. Plattform und Angebot mit realer Vergütung und Teilnahmebedingungen wählen. Bei offener Wettbewerbs-Bounty gelten deren Einreichungs- und Award-Regeln.
2. Annahme oder Plattformzuteilung mit externer Referenz speichern. Workflow-Freigaben und geforderten Zustellkanal prüfen.
3. Ergebnis erstellen. Einreichung genau einmal auslösen und die externe Quittung mit dem Auftrag verknüpfen.
4. Rechnung oder Plattform-Auszahlungsreferenz zuordnen. Zahlung erst nach Abgleich buchen.
5. `/einnahmen` prüfen und tatsächlichen Konto- oder Blockchain-Beleg getrennt dokumentieren.

Empfangs- und Zustellzugänge gehören in Railway Secrets. Sie werden nicht in den Chat oder das Repository kopiert.

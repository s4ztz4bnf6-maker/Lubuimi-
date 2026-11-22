/** Free local browser text-to-speech: no voice API key, no audio upload. */
export const voicePage = `<!doctype html>
<html lang="de"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<meta http-equiv="Content-Security-Policy" content="default-src 'none'; script-src 'unsafe-inline'; style-src 'unsafe-inline'; base-uri 'none'; form-action 'none'">
<title>JARVIS – Stimme</title><style>body{font:16px system-ui;background:#101827;color:#f5f7ff;max-width:660px;margin:3rem auto;padding:1rem}textarea{width:100%;height:130px;background:#1e293b;color:white;padding:12px;box-sizing:border-box;border-radius:8px}button{padding:12px 20px;margin:10px 8px 0 0;border:0;border-radius:8px;cursor:pointer}small{color:#bac5da}</style></head>
<body><h1>JARVIS – lokale Stimme</h1><p>Sprachausgabe erfolgt ausschließlich im Browser. Keine Audio-Daten werden an JARVIS übertragen.</p>
<label for="message">Text</label><textarea id="message" maxlength="1200">Guten Tag. Ich bin JARVIS, dein KI-Assistent.</textarea>
<div><button id="speak">Sprechen</button><button id="stop">Stoppen</button></div>
<p id="status" role="status"></p><small>Verwendet die auf deinem Gerät verfügbaren Stimmen. Funktioniert nur in Browsern mit Sprachsynthese.</small>
<script>
const status=document.getElementById("status");
document.getElementById("speak").addEventListener("click",()=>{
 if(!("speechSynthesis" in window)){status.textContent="Sprachausgabe nicht verfügbar";return}
 speechSynthesis.cancel();
 const text=document.getElementById("message").value.trim();
 if(!text){status.textContent="Bitte Text eingeben";return}
 const utterance=new SpeechSynthesisUtterance(text);utterance.lang="de-DE";utterance.rate=1;
 utterance.onstart=()=>status.textContent="JARVIS spricht";
 utterance.onend=()=>status.textContent="Fertig";
 utterance.onerror=()=>status.textContent="Sprachausgabe fehlgeschlagen";
 speechSynthesis.speak(utterance);
});
document.getElementById("stop").addEventListener("click",()=>{if("speechSynthesis" in window)speechSynthesis.cancel();status.textContent="Gestoppt"});
</script></body></html>`;

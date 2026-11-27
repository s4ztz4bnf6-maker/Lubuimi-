// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
import { spawnSync } from "node:child_process";
const [expected, sep, ...cmd] = process.argv.slice(2);
if (!/^\d+$/.test(expected ?? "") || sep !== "--" || !cmd.length) process.exit(2);
const r = spawnSync(cmd[0], cmd.slice(1), {encoding:"utf8", timeout:30000, killSignal:"SIGKILL"});
process.stdout.write(r.stdout ?? "");
process.stderr.write(r.stderr ?? "");
const n = (r.stdout ?? "").match(/^PASS /gm)?.length ?? 0;
if (r.error || r.status !== 0 || n !== Number(expected)) {
 console.error("FAIL", r.error?.message, r.status, n, expected); process.exit(1);
}
console.log(`OK: genau ${n} von ${expected} Prüfungen bestanden`);

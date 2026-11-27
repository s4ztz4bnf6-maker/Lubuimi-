// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
// Copyright (c) 2026 Ta-Yoshua Lubuimi. All rights reserved.
import {execFileSync} from "node:child_process";
const git=args=>execFileSync("git",args,{encoding:"utf8",maxBuffer:32*1024*1024});
const ref=process.argv[2]||"HEAD";
if(!/^[A-Za-z0-9_./-]+$/.test(ref)||ref.startsWith("-"))throw Error("INVALID_REF");
const sha=git(["rev-parse","--verify",ref+"^{commit}"]).trim();
const paths=git(["ls-tree","-r","--name-only","-z",sha,"--","JARVIS-Core"]).split("\0").filter(Boolean);
for(const path of paths){
 if(!/\.(mjs|cjs|js|ts|tsx|sql|md|py|sh|html|css|json|ya?ml)$/i.test(path)){console.log(JSON.stringify({path,status:"manual_review"}));continue;}
 const content=git(["show",sha+":"+path]);
 const head=content.split(/\r?\n/).slice(0,30).join("\n");
 const licenses=[...head.matchAll(/SPDX-License-Identifier:\s*([^\r\n]+)/g)].map(m=>m[1].trim());
 const status=licenses.some(x=>x!=="LicenseRef-DJO2-Proprietary")?"license_review":licenses.length&&head.includes("Ta-Yoshua Lubuimi")?"proprietary_header_present":"ownership_and_header_review";
 console.log(JSON.stringify({path,status,licenses}));
}

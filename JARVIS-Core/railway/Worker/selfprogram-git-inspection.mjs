// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
// Copyright (c) 2026 Ta-Yoshua Lubuimi. All rights reserved.
import {spawnSync} from "node:child_process";
import {validatePatchPaths} from "./selfprogram-patch-policy.mjs";
export function inspectGitPaths({baseCommit,diff,cwd}){
 if(!/^[a-f0-9]{40}$/.test(baseCommit)||typeof diff!=="string"||!diff.trim()||Buffer.byteLength(diff)>200000||diff.includes("\0"))throw Error("INVALID_PATCH");
 const git=(args,input)=>{const r=spawnSync("git",args,{cwd,input,encoding:"utf8",timeout:10000,maxBuffer:1000000,env:{PATH:process.env.PATH,GIT_CONFIG_NOSYSTEM:"1",GIT_CONFIG_GLOBAL:"/dev/null",GIT_TERMINAL_PROMPT:"0"}});if(r.status!==0)throw Error("GIT_INSPECTION_FAILED");return r.stdout;};
 if(git(["rev-parse","HEAD"]).trim()!==baseCommit)throw Error("BASE_COMMIT_MISMATCH");
 if(git(["status","--porcelain","--untracked-files=all"]).trim())throw Error("CHECKOUT_NOT_CLEAN");
 if(/^(?:GIT binary patch|Binary files |rename |copy |old mode |new mode |new file mode |deleted file mode |Submodule )/m.test(diff))throw Error("UNSUPPORTED_PATCH_TYPE");
 const raw=git(["apply","--numstat","-z","-"],diff);
 const paths=raw.split("\0").filter(Boolean).map(record=>{const m=/^\d+\t\d+\t([^\t\r\n]+)$/.exec(record);if(!m)throw Error("INVALID_GIT_PATH");return m[1];});
 validatePatchPaths(paths);
 for(const path of paths){
 const entry=git(["ls-tree",baseCommit,"--",path]);
 if(!entry.startsWith("100644 blob ")&&!entry.startsWith("100755 blob "))throw Error("NOT_REGULAR_TRACKED_FILE");
 }
 git(["apply","--check","--index","-"],diff);
 return [...new Set(paths)];
}
// Requires a trusted isolated checkout at the exact base commit.
// No patch application, commit, push or deployment.

// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
// Copyright (c) 2026 Ta-Yoshua Lubuimi. All rights reserved.
import test from "node:test";
import assert from "node:assert/strict";
import {mkdtempSync,mkdirSync,writeFileSync,rmSync} from "node:fs";
import {tmpdir} from "node:os";
import {join,dirname} from "node:path";
import {execFileSync} from "node:child_process";
import {inspectGitPaths} from "../selfprogram-git-inspection.mjs";
test("real Git inspection accepts only allowed regular tracked file modifications",()=>{
 const cwd=mkdtempSync(join(tmpdir(),"djo2-git-"));
 const git=(...args)=>execFileSync("git",args,{cwd,encoding:"utf8"});
 const allowed="JARVIS-Core/railway/Worker/context-step-plan.mjs";
 const forbidden="outside.txt";
 try{
 git("init","-q");git("config","user.email","test@example.invalid");git("config","user.name","Test");
 mkdirSync(dirname(join(cwd,allowed)),{recursive:true});
 for(const p of [allowed,forbidden])writeFileSync(join(cwd,p),"original\n");
 git("add",".");git("commit","-qm","fixture");
 const baseCommit=git("rev-parse","HEAD").trim();
 const patch=p=>{writeFileSync(join(cwd,p),"changed\n");const diff=git("diff","--",p);git("restore","--",p);return diff;};
 const diff=patch(allowed);
 assert.deepEqual(inspectGitPaths({cwd,baseCommit,diff}),[allowed]);
 assert.throws(()=>inspectGitPaths({cwd,baseCommit,diff:patch(forbidden)}),/PATCH_PATH_NOT_ALLOWED/);
 assert.throws(()=>inspectGitPaths({cwd,baseCommit:"0".repeat(40),diff}),/BASE_COMMIT_MISMATCH/);
 assert.throws(()=>inspectGitPaths({cwd,baseCommit,diff:diff.replaceAll(allowed,"../escape")}));
 assert.throws(()=>inspectGitPaths({cwd,baseCommit,diff:"GIT binary patch\n"+diff}),/UNSUPPORTED_PATCH_TYPE/);
 writeFileSync(join(cwd,allowed),"dirty\n");
 assert.throws(()=>inspectGitPaths({cwd,baseCommit,diff}),/CHECKOUT_NOT_CLEAN/);
 }finally{rmSync(cwd,{recursive:true,force:true});}
});

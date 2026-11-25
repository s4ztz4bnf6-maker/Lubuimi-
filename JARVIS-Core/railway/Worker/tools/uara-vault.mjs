// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
import {createCipheriv,createDecipheriv,randomBytes} from "node:crypto";
function validate(key,scope) {
 if (!Buffer.isBuffer(key)||key.length!==32) throw new Error("AES-256 key required");
 if(typeof scope!=="string"||!scope.trim()) throw new Error("credential scope required");
}
export function sealCredential(value,key,scope) {
 validate(key,scope);
 const iv=randomBytes(12);
 const cipher=createCipheriv("aes-256-gcm",key,iv);
 cipher.setAAD(Buffer.from(scope,"utf8"));
 const ciphertext=Buffer.concat([cipher.update(JSON.stringify(value),"utf8"),cipher.final()]);
 return {version:1,iv:iv.toString("base64"),tag:cipher.getAuthTag().toString("base64"),ciphertext:ciphertext.toString("base64")};
}
export function openCredential(record,key,scope) {
 validate(key,scope);
 if(record?.version!==1) throw new Error("unsupported vault version");
 const iv=Buffer.from(record.iv,"base64"),tag=Buffer.from(record.tag,"base64");
 if(iv.length!==12||tag.length!==16) throw new Error("invalid encrypted record");
 const decipher=createDecipheriv("aes-256-gcm",key,iv,{authTagLength:16});
 decipher.setAAD(Buffer.from(scope,"utf8"));
 decipher.setAuthTag(tag);
 return JSON.parse(Buffer.concat([decipher.update(Buffer.from(record.ciphertext,"base64")),decipher.final()]).toString("utf8"));
}

import { createHash } from 'node:crypto';
import { issueAgentCredential, authorizeAgent } from './credentials.mjs';
export function createAgentStore(sql) {
  return {
    async issue(scopes, ttlMs) {
      const {token,record}=issueAgentCredential(scopes,ttlMs);
      await sql.unsafe('INSERT INTO djo2_agent_credentials(token_hash,scopes,expires_at) VALUES ($1,$2,$3)',[record.hash,record.scopes,new Date(record.expiresAt)]);
      return {token,expiresAt:record.expiresAt,scopes:record.scopes};
    },
    async authorize(header,scope,options={}) {
      if(typeof header!=='string'||!/^Bearer [a-f0-9]{64}$/.test(header)) return {ok:false,status:401};
      const hash=createHash('sha256').update(header.slice(7)).digest('hex');
      const [row]=await sql.unsafe('SELECT token_hash,scopes,expires_at,revoked FROM djo2_agent_credentials WHERE token_hash=$1',[hash]);
      return authorizeAgent(header,row&&{hash:row.token_hash,scopes:row.scopes,expiresAt:new Date(row.expires_at).getTime(),revoked:row.revoked},scope,options);
    },
    async rotate(hash, ttlMs) {
      if(typeof hash!=='string'||!/^[a-f0-9]{64}$/.test(hash)) throw new Error('invalid credential reference');
      return sql.begin(async tx => {
        const [old]=await tx.unsafe('SELECT scopes FROM djo2_agent_credentials WHERE token_hash=$1 AND NOT revoked AND expires_at>NOW() FOR UPDATE',[hash]);
        if(!old) return null;
        const {token,record}=issueAgentCredential(old.scopes,ttlMs);
        await tx.unsafe('INSERT INTO djo2_agent_credentials(token_hash,scopes,expires_at) VALUES ($1,$2,$3)',[record.hash,record.scopes,new Date(record.expiresAt)]);
        await tx.unsafe('UPDATE djo2_agent_credentials SET revoked=true WHERE token_hash=$1',[hash]);
        return {token,expiresAt:record.expiresAt,scopes:record.scopes};
      });
    },
    async revoke(hash) {
      if(!/^[a-f0-9]{64}$/.test(hash)) throw new Error('invalid hash');
      await sql.unsafe('UPDATE djo2_agent_credentials SET revoked=true WHERE token_hash=$1',[hash]);
    }
  };
}

import { randomBytes, createHash, timingSafeEqual } from 'node:crypto';

const digest = token => createHash('sha256').update(token, 'utf8').digest('hex');
const allowed = new Set(['agent:read', 'agent:execute']);

export function issueAgentCredential(scopes, ttlMs = 3600000) {
  if (!Array.isArray(scopes) || !scopes.length || scopes.some(s => !allowed.has(s))) throw new Error('invalid scopes');
  if (!Number.isSafeInteger(ttlMs) || ttlMs <= 0 || ttlMs > 86400000) throw new Error('invalid ttl');
  const token = randomBytes(32).toString('hex');
  return { token, record: { hash: digest(token), scopes: [...new Set(scopes)], expiresAt: Date.now() + ttlMs, revoked: false } };
}

export function authorizeAgent(header, record, scope, { now = Date.now(), requiresSpend = false } = {}) {
  if (typeof header !== 'string' || !/^Bearer [a-f0-9]{64}$/.test(header) || !record || record.revoked !== false || !Number.isFinite(record.expiresAt) || now >= record.expiresAt || typeof record.hash !== 'string' || !/^[a-f0-9]{64}$/.test(record.hash)) return { ok: false, status: 401 };
  if (!timingSafeEqual(Buffer.from(digest(header.slice(7)), 'hex'), Buffer.from(record.hash, 'hex'))) return { ok: false, status: 401 };
  if (requiresSpend || !allowed.has(scope) || !Array.isArray(record.scopes) || !record.scopes.includes(scope)) return { ok: false, status: 403 };
  return { ok: true, status: 200 };
}

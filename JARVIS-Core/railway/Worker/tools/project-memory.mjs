// SPDX-License-Identifier: Apache-2.0
export async function initializeProjectMemory(sql) {
  await sql`CREATE TABLE IF NOT EXISTS djo2_project_memory (
    memory_key TEXT NOT NULL,
    revision BIGINT NOT NULL,
    payload JSONB NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    PRIMARY KEY(memory_key,revision)
  )`;
  await sql`INSERT INTO djo2_project_memory(memory_key,revision,payload)
    VALUES ('continuity-policy',1,${sql.json({preserveExistingData:true,zeroSpend:true,applicationLicense:"Apache-2.0",externalPaymentEvidenceRequired:true,torDefaultEnabled:false})})
    ON CONFLICT DO NOTHING`;
}

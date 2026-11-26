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
  await sql`INSERT INTO djo2_project_memory(memory_key,revision,payload)
    VALUES ('continuity-policy',2,${sql.json({preserveExistingData:true,zeroSpend:true,applicationLicense:'LicenseRef-DJO2-Proprietary',paidOnlyNewGrants:true,preservePriorGrants:true,preserveThirdPartyRights:true,externalPaymentEvidenceRequired:true,torDefaultEnabled:false,railwayRenameDeferred:true})})
    ON CONFLICT DO NOTHING`;
  await sql`INSERT INTO djo2_project_memory(memory_key,revision,payload)
    VALUES ('project-checkpoint',1,${sql.json({date:'2026-11-26',brand:'DJO² IA',repository:'s4ztz4bnf6-maker/Lubuimi-',productionCompanionBranch:'djo2/companion-agent-auth-railway-release-20261126',pending:['owner authorization','session protection','security tests','deployment','live acceptance'],sessionMaxHours:24,adminMaxMinutes:15,zeroSpend:true})})
    ON CONFLICT DO NOTHING`;
  const verified = await sql`SELECT memory_key, revision FROM djo2_project_memory WHERE (memory_key = 'continuity-policy' AND revision = 2) OR (memory_key = 'project-checkpoint' AND revision = 1)`;
  if (verified.length !== 2) throw new Error('DJO2 project memory checkpoint missing');
  console.info('DJO2 project memory checkpoint verified: continuity-policy v2, project-checkpoint v1');
}

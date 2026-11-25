// Existing licensing history preserved; no new license grant. See JARVIS-Core/LICENSE-CORRECTION.md.
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
  await sql`INSERT INTO djo2_project_memory(memory_key,revision,payload) VALUES ('continuity-policy',2,${sql.json({preserveExistingData:true,zeroSpend:true,applicationLicense:null,apacheForNewOwnerContributions:false,externalPaymentEvidenceRequired:true,torDefaultEnabled:false,sharedDepartmentMemory:true,requireProvenance:true,neverFabricateRecall:true})}) ON CONFLICT DO NOTHING`;
}
export async function readProjectMemory(sql,key){
 const [row]=await sql`SELECT memory_key,revision,payload,created_at FROM djo2_project_memory WHERE memory_key=${key} ORDER BY revision DESC LIMIT 1`;
 return row??null;
}


// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
export async function inspectClaimTriggers(sql) {
  return sql.begin("read only", async tx => {
    const rows = await tx`SELECT t.tgname AS name, t.tgenabled AS enabled,
      pg_get_triggerdef(t.oid) AS definition, p.proname AS function_name,
      pg_get_functiondef(p.oid) AS function_source
      FROM pg_trigger t JOIN pg_proc p ON p.oid=t.tgfoid
      WHERE t.tgrelid='agent_tasks'::regclass AND NOT t.tgisinternal
      ORDER BY t.tgname`;
    return rows;
  });
}

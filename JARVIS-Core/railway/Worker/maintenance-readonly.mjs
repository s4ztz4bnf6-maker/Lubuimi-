// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
// Read-only diagnosis adapter; never expose task content.
export async function diagnoseDatabase(sql, mode) {
  return sql.begin("read only", async tx => {
    if (mode === "diagnose") {
      const [counts] = await tx`SELECT count(*)::int AS total,
        count(*) FILTER (WHERE (status='queued' OR (status='retry_wait' AND next_retry_at <= NOW())) AND attempt_count < max_attempts)::int AS claimable_now,
        count(*) FILTER (WHERE attempt_count >= max_attempts)::int AS attempts_exhausted,
        count(*) FILTER (WHERE status='retry_wait' AND next_retry_at > NOW())::int AS waiting,
        count(*) FILTER (WHERE status='retry_wait' AND next_retry_at IS NULL)::int AS retry_without_date,
        count(*) FILTER (WHERE status='running')::int AS running
        FROM agent_tasks`;
      const byStatus = await tx`SELECT status,count(*)::int AS count FROM agent_tasks GROUP BY status ORDER BY status`;
      return {maintenance:mode,...counts,byStatus};
    }
    if (/^task:[1-9][0-9]*$/.test(mode)) {
      const id=mode.slice(5);
      const [task]=await tx`SELECT id::text,status,attempt_count,max_attempts,next_retry_at,started_at,completed_at,created_at FROM agent_tasks WHERE id=${id}`;
      return {maintenance:mode,task:task??null};
    }
    throw new Error("MAINTENANCE_MODE_NOT_AUTHORIZED");
  });
}

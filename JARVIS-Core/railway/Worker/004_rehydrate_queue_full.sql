-- SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
-- Manual migration: execute only after production approval.
UPDATE agent_tasks SET status='retry_wait', next_retry_at=NOW()+INTERVAL '15 seconds' WHERE status='failed' AND attempt_count=0 AND started_at IS NULL AND error='[DJO2_POLICY:queue_full:owner] Admission deferred; queue capacity reached';

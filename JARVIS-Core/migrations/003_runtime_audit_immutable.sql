-- Make runtime audit events immutable at the database layer.
-- Apply after 001_autonomous_runtime.sql and 002_runtime_task_results.sql.

CREATE OR REPLACE FUNCTION jarvis_runtime_reject_audit_mutation()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
  RAISE EXCEPTION 'jarvis runtime audit is append-only; % is forbidden', TG_OP
    USING ERRCODE = '55000';
END;
$$;

DROP TRIGGER IF EXISTS jarvis_runtime_audit_no_mutation
  ON jarvis_runtime_audit;

CREATE TRIGGER jarvis_runtime_audit_no_mutation
BEFORE UPDATE OR DELETE ON jarvis_runtime_audit
FOR EACH ROW
EXECUTE FUNCTION jarvis_runtime_reject_audit_mutation();

-- Defense in depth for default PUBLIC grants. Runtime roles should receive
-- only SELECT and INSERT on this table and must not own it.
REVOKE UPDATE, DELETE, TRUNCATE ON jarvis_runtime_audit FROM PUBLIC;

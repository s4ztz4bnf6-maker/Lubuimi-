BEGIN;
CREATE TABLE IF NOT EXISTS djo2_economic_slots (
 slot int PRIMARY KEY CHECK (slot BETWEEN 1 AND 3),
 task_ref text UNIQUE, taken_at timestamptz
);
INSERT INTO djo2_economic_slots(slot) SELECT g FROM generate_series(1,3) g ON CONFLICT DO NOTHING;
CREATE OR REPLACE FUNCTION djo2_take_slot(p_ref text) RETURNS int LANGUAGE plpgsql AS $$
DECLARE s int;
BEGIN
 IF p_ref IS NULL OR btrim(p_ref)='' THEN RAISE EXCEPTION 'Invalid task reference'; END IF;
 PERFORM pg_advisory_xact_lock(hashtext('djo2_economic_slots'));
 SELECT slot INTO s FROM djo2_economic_slots WHERE task_ref=p_ref;
 IF FOUND THEN RETURN s; END IF;
 UPDATE djo2_economic_slots SET task_ref=p_ref,taken_at=now()
 WHERE slot=(SELECT slot FROM djo2_economic_slots WHERE task_ref IS NULL ORDER BY slot FOR UPDATE LIMIT 1)
 RETURNING slot INTO s;
 RETURN s;
END $$;
CREATE OR REPLACE FUNCTION djo2_release_slot(p_ref text) RETURNS boolean LANGUAGE plpgsql AS $$
BEGIN
 PERFORM pg_advisory_xact_lock(hashtext('djo2_economic_slots'));
 UPDATE djo2_economic_slots SET task_ref=NULL,taken_at=NULL WHERE task_ref=p_ref;
 RETURN FOUND;
END $$;
CREATE OR REPLACE FUNCTION djo2_queue_has_room(p_table regclass,p_status_col name,p_open text[],p_max int) RETURNS boolean LANGUAGE plpgsql AS $$
DECLARE n bigint;
BEGIN
 PERFORM pg_advisory_xact_lock(hashtext('djo2_queue_admit'));
 EXECUTE format('SELECT count(*) FROM %s WHERE %I::text = ANY($1)',p_table,p_status_col) INTO n USING p_open;
 RETURN n<p_max;
END $$;
COMMIT;

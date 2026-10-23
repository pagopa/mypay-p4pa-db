-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE TABLE IF NOT EXISTS orchestrator.migration_execution (
    id UUID DEFAULT gen_random_uuid(),
    status VARCHAR(20) NOT NULL,
    file_type_count_completed INT NOT NULL,
    ipaCodes VARCHAR(500) NOT NULL,
    cycle_mode VARCHAR(20) NOT NULL,
    parent_execution_id UUID,
    logical_keys text COLLATE pg_catalog."default",
    file_types text COLLATE pg_catalog."default" NOT NULL,
    date_from DATE,
    date_to DATE,
    since_date TIMESTAMP,
    last_successful_extraction_at TIMESTAMP,
    error_code VARCHAR(50),
    error_msg TEXT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT now(),
    updated_at TIMESTAMP NOT NULL DEFAULT now() ,
	update_trace_id text DEFAULT '-'::text NOT NULL,
    CONSTRAINT migration_execution_pkey PRIMARY KEY (id),
    CONSTRAINT migration_execution_parent_execution_id_fkey FOREIGN KEY (parent_execution_id)
    REFERENCES orchestrator.migration_execution (id) MATCH SIMPLE
                                                    ON UPDATE NO ACTION
                                                    ON DELETE NO ACTION

);

CREATE INDEX IF NOT EXISTS idx_migration_execution_org_status ON orchestrator.migration_execution(status);

-- final commit
COMMIT;
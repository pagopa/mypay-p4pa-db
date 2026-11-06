-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE TABLE IF NOT EXISTS orchestrator.migration_file_execution_detail (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    migration_file_execution_id UUID NOT NULL,
    status VARCHAR(20) NOT NULL,
    file_name VARCHAR(256) NOT NULL,
    upload_detail_id INT8,
    file_size INT8 NOT NULL,
    error_description TEXT,
    discard_file_name TEXT,
    num_total_rows INT4,
    num_correctly_imported_rows INT4,
    creation_date TIMESTAMP NOT NULL DEFAULT now(),
    update_date TIMESTAMP NOT NULL DEFAULT now(),
    update_trace_id TEXT NOT NULL DEFAULT '-',

    CONSTRAINT file_exec_detail_file_exec_fk FOREIGN KEY (migration_file_execution_id)
        REFERENCES orchestrator.migration_file_execution(id)
            ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_migration_file_execution_detail_execution_id
    ON orchestrator.migration_file_execution_detail(migration_file_execution_id);

-- final commit
COMMIT;
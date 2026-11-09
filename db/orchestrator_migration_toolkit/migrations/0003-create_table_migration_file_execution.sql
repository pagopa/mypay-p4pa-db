-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE TABLE IF NOT EXISTS orchestrator.migration_file_execution (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    migration_id UUID NOT NULL,
    file_type VARCHAR(50) NOT NULL,
    status VARCHAR(20) NOT NULL,
    extraction_id VARCHAR(100),
    file_path TEXT,
    extraction_error_code VARCHAR(100),
    extraction_error_msg TEXT,
    upload_id INT8,
    upload_status VARCHAR(20),
    upload_error_code VARCHAR(100),
    upload_error_msg TEXT,
    extraction_started_at TIMESTAMP,
    extraction_completed_at TIMESTAMP,
    upload_started_at TIMESTAMP,
    upload_completed_at TIMESTAMP,
    creation_date TIMESTAMP NOT NULL DEFAULT now(),
    update_date TIMESTAMP NOT NULL DEFAULT now(),
    update_trace_id TEXT NOT NULL DEFAULT '-',

    CONSTRAINT file_exec_migration_fk FOREIGN KEY (migration_id)
        REFERENCES orchestrator.migration_execution(id)
            ON DELETE CASCADE,
    CONSTRAINT file_exec_unique UNIQUE (migration_id, file_type)
);

CREATE INDEX IF NOT EXISTS idx_migration_file_exec_status ON orchestrator.migration_file_execution(migration_id, status);

-- final commit
COMMIT;
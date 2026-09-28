-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE TABLE IF NOT EXISTS orchestrator.migration_file_execution (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    migration_id UUID NOT NULL,
    file_type VARCHAR(50)  NOT NULL,
    status VARCHAR(20)  NOT NULL,
    extractor_id VARCHAR(100),
    file_path VARCHAR(512),
    extractor_error_code VARCHAR(100),
    extractor_error_msg TEXT,
    upload_id INT8,
    upload_status VARCHAR(20),
    upload_error_code VARCHAR(100),
    upload_error_msg TEXT,
    extraction_started_at TIMESTAMP,
    extraction_completed_at TIMESTAMP,
    upload_started_at TIMESTAMP,
    upload_completed_at TIMESTAMP,
    created_at TIMESTAMP NOT NULL DEFAULT now(),
    updated_at TIMESTAMP NOT NULL DEFAULT now(),
    CONSTRAINT file_exec_migration_fk FOREIGN KEY (migration_id) REFERENCES orchestrator.migration_execution(id) ON DELETE CASCADE,
    CONSTRAINT file_exec_unique UNIQUE (migration_id, file_type)
);

CREATE INDEX IF NOT EXISTS idx_migration_file_exec_status ON orchestrator.migration_file_execution(migration_id, status);

-- final commit
COMMIT;
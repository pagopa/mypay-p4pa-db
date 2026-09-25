-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE TABLE IF NOT EXISTS migration_file_execution_detail (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    migration_file_execution_id UUID NOT NULL REFERENCES migration_file_execution(id) ON DELETE CASCADE,
    status VARCHAR(20) NOT NULL,
    file_name VARCHAR(256) NOT NULL,
    upload_detail_id INT8,
    file_size INT8 NOT NULL,
    status VARCHAR(50) NOT NULL,
    error_description TEXT NULL,
    discard_file_name TEXT NULL,
    num_total_rows INT4 NULL,
    num_correctly_imported_rows INT4 NULL,
    created_at TIMESTAMP NOT NULL DEFAULT now(),
    updated_at TIMESTAMP NOT NULL DEFAULT now(),
    CONSTRAINT file_exec_migration_fk FOREIGN KEY (migration_file_execution_id) REFERENCES migration_file_execution (id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_migration_file_execution_detail_execution_id ON migration_file_execution(migration_file_execution_id);

-- final commit
COMMIT;
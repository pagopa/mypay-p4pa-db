-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE TABLE IF NOT EXISTS migration_dag_dependency (
    id SERIAL PRIMARY KEY,
    file_type VARCHAR(50) NOT NULL,
    depends_on VARCHAR(50) NOT NULL,
    label VARCHAR(200),

    CONSTRAINT dag_dep_unique UNIQUE (file_type, depends_on)
);

-- final commit
COMMIT;
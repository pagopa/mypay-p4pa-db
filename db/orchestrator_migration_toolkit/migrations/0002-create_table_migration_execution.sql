-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE TABLE IF NOT EXISTS migration_execution (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    broker_ipa_code VARCHAR(50) NOT NULL,
    status VARCHAR(20) NOT NULL,
    cycle_number INT NOT NULL,
    ipaCodes VARCHAR(500) NOT NULL,
    cycle_mode VARCHAR(20) NOT NULL,
    parent_execution_id UUID REFERENCES migration_execution(id),
    date_from DATE,
    date_to DATE,
    since_date TIMESTAMP,
    last_successful_extraction_at TIMESTAMP,
    error_code VARCHAR(50),
    error_msg TEXT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT now(),
    updated_at TIMESTAMP NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_migration_execution_org_status ON migration_execution(broker_ipa_code, status);
CREATE INDEX IF NOT EXISTS idx_migration_execution_cycle_number ON migration_execution(broker_ipa_code, cycle_number DESC);

-- final commit
COMMIT;
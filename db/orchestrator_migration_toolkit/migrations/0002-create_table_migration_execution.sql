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
    updated_at TIMESTAMP NOT NULL DEFAULT now(),
    CONSTRAINT migration_execution_org_fk FOREIGN KEY (org_ipa) REFERENCES mygov_ente(cod_ipa_ente)
);

CREATE INDEX IF NOT EXISTS idx_migration_execution_org_status ON migration_execution(org_ipa, status);
CREATE INDEX IF NOT EXISTS idx_migration_execution_cycle_number ON migration_execution(org_ipa, cycle_number DESC);

-- final commit
COMMIT;
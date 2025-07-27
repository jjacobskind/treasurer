-- bank_accounts table
CREATE TABLE bank_accounts (
    id BIGSERIAL PRIMARY KEY,
    bank_name VARCHAR(60),
    acct_last4 CHAR(4),
    acct_type VARCHAR(20),
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now()
);
COMMENT ON TABLE bank_accounts IS 'Bank accounts used by the coop';
COMMENT ON COLUMN bank_accounts.id IS 'Primary key';
COMMENT ON COLUMN bank_accounts.bank_name IS 'Name of the bank';
COMMENT ON COLUMN bank_accounts.acct_last4 IS 'Last four digits of account';
COMMENT ON COLUMN bank_accounts.acct_type IS 'Type of account';
COMMENT ON COLUMN bank_accounts.created_at IS 'Row creation timestamp';
COMMENT ON COLUMN bank_accounts.updated_at IS 'Row update timestamp';

-- gl_accounts table
CREATE TABLE gl_accounts (
    gl_account VARCHAR(10) PRIMARY KEY,
    description VARCHAR(120),
    type VARCHAR(20),
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now()
);
COMMENT ON TABLE gl_accounts IS 'General ledger accounts';
COMMENT ON COLUMN gl_accounts.gl_account IS 'Account code';
COMMENT ON COLUMN gl_accounts.description IS 'Account description';
COMMENT ON COLUMN gl_accounts.type IS 'Account type';
COMMENT ON COLUMN gl_accounts.created_at IS 'Row creation timestamp';
COMMENT ON COLUMN gl_accounts.updated_at IS 'Row update timestamp';

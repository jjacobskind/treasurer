-- budgets table
CREATE TABLE budgets (
    period_id CHAR(7) REFERENCES periods(id) ON UPDATE CASCADE ON DELETE RESTRICT,
    gl_account VARCHAR(10) REFERENCES gl_accounts(id) ON UPDATE CASCADE ON DELETE RESTRICT,
    budget_amount NUMERIC(14,2),
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),
    PRIMARY KEY (period_id, gl_account)
);
CREATE INDEX idx_budgets_period_id ON budgets(period_id);
CREATE INDEX idx_budgets_gl_account ON budgets(gl_account);
COMMENT ON TABLE budgets IS 'Budget amounts by period and account';
COMMENT ON COLUMN budgets.period_id IS 'Accounting period';
COMMENT ON COLUMN budgets.gl_account IS 'GL account';
COMMENT ON COLUMN budgets.budget_amount IS 'Budget amount';
COMMENT ON COLUMN budgets.created_at IS 'Row creation timestamp';
COMMENT ON COLUMN budgets.updated_at IS 'Row update timestamp';

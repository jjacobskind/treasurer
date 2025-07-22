-- cash_account_summaries table
CREATE TABLE cash_account_summaries (
    period_id CHAR(7) REFERENCES periods(id) ON UPDATE CASCADE ON DELETE RESTRICT,
    bank_account_id BIGINT REFERENCES bank_accounts(id) ON UPDATE CASCADE ON DELETE RESTRICT,
    begin_balance NUMERIC(14,2),
    receipts NUMERIC(14,2),
    disbursements NUMERIC(14,2),
    net_change NUMERIC(14,2),
    end_balance NUMERIC(14,2),
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),
    PRIMARY KEY (period_id, bank_account_id)
);
CREATE INDEX idx_cash_account_summaries_period_id ON cash_account_summaries(period_id);
CREATE INDEX idx_cash_account_summaries_bank_account_id ON cash_account_summaries(bank_account_id);
COMMENT ON TABLE cash_account_summaries IS 'Monthly summary of cash accounts';
COMMENT ON COLUMN cash_account_summaries.period_id IS 'Accounting period';
COMMENT ON COLUMN cash_account_summaries.bank_account_id IS 'Bank account';
COMMENT ON COLUMN cash_account_summaries.begin_balance IS 'Beginning balance';
COMMENT ON COLUMN cash_account_summaries.receipts IS 'Cash receipts';
COMMENT ON COLUMN cash_account_summaries.disbursements IS 'Cash disbursements';
COMMENT ON COLUMN cash_account_summaries.net_change IS 'Net change in cash';
COMMENT ON COLUMN cash_account_summaries.end_balance IS 'Ending balance';
COMMENT ON COLUMN cash_account_summaries.created_at IS 'Row creation timestamp';
COMMENT ON COLUMN cash_account_summaries.updated_at IS 'Row update timestamp';

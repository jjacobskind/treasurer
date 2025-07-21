-- periods table
CREATE TABLE periods (
    period_id CHAR(7) PRIMARY KEY,
    start_date DATE,
    end_date DATE,
    statement_issue_date DATE,
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now()
);
COMMENT ON TABLE periods IS 'Accounting periods (YYYY-MM)';
COMMENT ON COLUMN periods.period_id IS 'YYYY-MM identifier';
COMMENT ON COLUMN periods.start_date IS 'Start of period';
COMMENT ON COLUMN periods.end_date IS 'End of period';
COMMENT ON COLUMN periods.statement_issue_date IS 'Date statement issued';
COMMENT ON COLUMN periods.created_at IS 'Row creation timestamp';
COMMENT ON COLUMN periods.updated_at IS 'Row update timestamp';

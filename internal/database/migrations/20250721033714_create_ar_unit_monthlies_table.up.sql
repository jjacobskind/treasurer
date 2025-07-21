-- ar_unit_monthlies table
CREATE TABLE ar_unit_monthlies (
    unit_id VARCHAR(10) REFERENCES units(unit_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    period_id CHAR(7) REFERENCES periods(period_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    charges NUMERIC(14,2),
    payments NUMERIC(14,2),
    ending_balance NUMERIC(14,2),
    aging_bucket VARCHAR(10),
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),
    PRIMARY KEY (unit_id, period_id)
);
CREATE INDEX idx_ar_unit_monthlies_unit_id ON ar_unit_monthlies(unit_id);
CREATE INDEX idx_ar_unit_monthlies_period_id ON ar_unit_monthlies(period_id);
COMMENT ON TABLE ar_unit_monthlies IS 'Monthly accounts receivable by unit';
COMMENT ON COLUMN ar_unit_monthlies.unit_id IS 'Unit identifier';
COMMENT ON COLUMN ar_unit_monthlies.period_id IS 'Accounting period';
COMMENT ON COLUMN ar_unit_monthlies.charges IS 'Charges for the period';
COMMENT ON COLUMN ar_unit_monthlies.payments IS 'Payments for the period';
COMMENT ON COLUMN ar_unit_monthlies.ending_balance IS 'Ending balance';
COMMENT ON COLUMN ar_unit_monthlies.aging_bucket IS 'Aging bucket';
COMMENT ON COLUMN ar_unit_monthlies.created_at IS 'Row creation timestamp';
COMMENT ON COLUMN ar_unit_monthlies.updated_at IS 'Row update timestamp';

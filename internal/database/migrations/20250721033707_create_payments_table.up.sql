-- payments table
CREATE TYPE payment_method AS ENUM ('CHECK', 'ACH', 'WIRE', 'CASH', 'AUTODB');
CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    bank_account_id INT REFERENCES bank_accounts(bank_account_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    payment_date DATE,
    method payment_method,
    vendor_id INT REFERENCES vendors(vendor_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    amount NUMERIC(14,2),
    cleared_flag BOOLEAN,
    reference_no VARCHAR(20),
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now()
);
CREATE INDEX idx_payments_bank_account_id ON payments(bank_account_id);
CREATE INDEX idx_payments_vendor_id ON payments(vendor_id);
CREATE INDEX idx_payments_method ON payments(method);
COMMENT ON TABLE payments IS 'Payments issued by the coop';
COMMENT ON COLUMN payments.payment_id IS 'Primary key';
COMMENT ON COLUMN payments.bank_account_id IS 'Related bank account';
COMMENT ON COLUMN payments.payment_date IS 'Date of payment';
COMMENT ON COLUMN payments.method IS 'Payment method';
COMMENT ON COLUMN payments.vendor_id IS 'Vendor receiving payment';
COMMENT ON COLUMN payments.amount IS 'Payment amount';
COMMENT ON COLUMN payments.cleared_flag IS 'Has the payment cleared';
COMMENT ON COLUMN payments.reference_no IS 'Check number or ACH trace';
COMMENT ON COLUMN payments.created_at IS 'Row creation timestamp';
COMMENT ON COLUMN payments.updated_at IS 'Row update timestamp';

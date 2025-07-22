-- payment_applies table
CREATE TABLE payment_applies (
    payment_id INT REFERENCES payments(payment_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    ap_invoice_id INT REFERENCES ap_invoices(ap_invoice_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    amount_applied NUMERIC(14,2),
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),
    PRIMARY KEY (payment_id, ap_invoice_id)
);
CREATE INDEX idx_payment_applies_payment_id ON payment_applies(payment_id);
CREATE INDEX idx_payment_applies_ap_invoice_id ON payment_applies(ap_invoice_id);
COMMENT ON TABLE payment_applies IS 'Application of payments to invoices';
COMMENT ON COLUMN payment_applies.payment_id IS 'Related payment';
COMMENT ON COLUMN payment_applies.ap_invoice_id IS 'Applied invoice';
COMMENT ON COLUMN payment_applies.amount_applied IS 'Amount applied';
COMMENT ON COLUMN payment_applies.created_at IS 'Row creation timestamp';
COMMENT ON COLUMN payment_applies.updated_at IS 'Row update timestamp';

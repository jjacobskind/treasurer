-- ap_invoices table
CREATE TABLE ap_invoices (
    ap_invoice_id SERIAL PRIMARY KEY,
    vendor_id INT REFERENCES vendors(vendor_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    invoice_number VARCHAR(40),
    invoice_date DATE,
    due_date DATE,
    gl_account_default VARCHAR(10) REFERENCES gl_accounts(gl_account) ON UPDATE CASCADE ON DELETE RESTRICT,
    amount_total NUMERIC(14,2),
    amount_open NUMERIC(14,2),
    pdf_ref VARCHAR(60),
    aging_30 NUMERIC(14,2),
    aging_60 NUMERIC(14,2),
    aging_90 NUMERIC(14,2),
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now()
);
CREATE INDEX idx_ap_invoices_vendor_id ON ap_invoices(vendor_id);
CREATE INDEX idx_ap_invoices_gl_account_default ON ap_invoices(gl_account_default);
COMMENT ON TABLE ap_invoices IS 'Accounts payable invoices';
COMMENT ON COLUMN ap_invoices.ap_invoice_id IS 'Primary key';
COMMENT ON COLUMN ap_invoices.vendor_id IS 'Vendor for this invoice';
COMMENT ON COLUMN ap_invoices.invoice_number IS 'Vendor invoice number';
COMMENT ON COLUMN ap_invoices.invoice_date IS 'Invoice date';
COMMENT ON COLUMN ap_invoices.due_date IS 'Due date';
COMMENT ON COLUMN ap_invoices.gl_account_default IS 'Default GL account';
COMMENT ON COLUMN ap_invoices.amount_total IS 'Total amount';
COMMENT ON COLUMN ap_invoices.amount_open IS 'Open amount';
COMMENT ON COLUMN ap_invoices.pdf_ref IS 'Reference to scanned PDF';
COMMENT ON COLUMN ap_invoices.aging_30 IS 'Amount 30 days past due';
COMMENT ON COLUMN ap_invoices.aging_60 IS 'Amount 60 days past due';
COMMENT ON COLUMN ap_invoices.aging_90 IS 'Amount 90 days past due';
COMMENT ON COLUMN ap_invoices.created_at IS 'Row creation timestamp';
COMMENT ON COLUMN ap_invoices.updated_at IS 'Row update timestamp';

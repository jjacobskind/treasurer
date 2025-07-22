-- vendors table
CREATE TABLE vendors (
    vendor_id SERIAL PRIMARY KEY,
    legal_name VARCHAR(120) UNIQUE,
    remit_address TEXT,
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now()
);
COMMENT ON TABLE vendors IS 'Vendors that provide goods or services';
COMMENT ON COLUMN vendors.vendor_id IS 'Primary key';
COMMENT ON COLUMN vendors.legal_name IS 'Vendor legal name';
COMMENT ON COLUMN vendors.remit_address IS 'Remittance address';
COMMENT ON COLUMN vendors.created_at IS 'Row creation timestamp';
COMMENT ON COLUMN vendors.updated_at IS 'Row update timestamp';

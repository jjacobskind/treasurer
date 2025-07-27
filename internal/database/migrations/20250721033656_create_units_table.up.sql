-- units table
CREATE TABLE units (
    id VARCHAR(10) PRIMARY KEY,
    line VARCHAR(10),
    floor SMALLINT,
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now()
);
COMMENT ON TABLE units IS 'Building units';
COMMENT ON COLUMN units.id IS 'Unit identifier';
COMMENT ON COLUMN units.line IS 'Line within the building';
COMMENT ON COLUMN units.floor IS 'Floor number';
COMMENT ON COLUMN units.created_at IS 'Row creation timestamp';
COMMENT ON COLUMN units.updated_at IS 'Row update timestamp';

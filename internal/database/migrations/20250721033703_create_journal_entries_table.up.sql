-- journal_entries table
CREATE TABLE journal_entries (
    journal_entry_id SERIAL PRIMARY KEY,
    period_id CHAR(7) REFERENCES periods(period_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    entry_date DATE,
    memo TEXT,
    source_doc VARCHAR(60),
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now()
);
CREATE INDEX idx_journal_entries_period_id ON journal_entries(period_id);
CREATE INDEX idx_journal_entries_source_doc ON journal_entries(source_doc);
COMMENT ON TABLE journal_entries IS 'Journal entry headers';
COMMENT ON COLUMN journal_entries.journal_entry_id IS 'Primary key';
COMMENT ON COLUMN journal_entries.period_id IS 'Related accounting period';
COMMENT ON COLUMN journal_entries.entry_date IS 'Date of entry';
COMMENT ON COLUMN journal_entries.memo IS 'Memo text';
COMMENT ON COLUMN journal_entries.source_doc IS 'Source document reference';
COMMENT ON COLUMN journal_entries.created_at IS 'Row creation timestamp';
COMMENT ON COLUMN journal_entries.updated_at IS 'Row update timestamp';

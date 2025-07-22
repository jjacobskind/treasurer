-- journal_entry_lines table
CREATE TABLE journal_entry_lines (
    id BIGSERIAL PRIMARY KEY,
    journal_entry_id BIGINT REFERENCES journal_entries(id) ON UPDATE CASCADE ON DELETE RESTRICT,
    gl_account VARCHAR(10) REFERENCES gl_accounts(id) ON UPDATE CASCADE ON DELETE RESTRICT,
    debit NUMERIC(14,2) NOT NULL DEFAULT 0,
    credit NUMERIC(14,2) NOT NULL DEFAULT 0,
    src_code VARCHAR(3),
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now()
);
CREATE INDEX idx_journal_entry_lines_journal_entry_id ON journal_entry_lines(journal_entry_id);
CREATE INDEX idx_journal_entry_lines_gl_account ON journal_entry_lines(gl_account);
CREATE INDEX idx_journal_entry_lines_src_code ON journal_entry_lines(src_code);
COMMENT ON TABLE journal_entry_lines IS 'Lines within a journal entry';
COMMENT ON COLUMN journal_entry_lines.id IS 'Primary key';
COMMENT ON COLUMN journal_entry_lines.journal_entry_id IS 'Related journal entry';
COMMENT ON COLUMN journal_entry_lines.gl_account IS 'GL account';
COMMENT ON COLUMN journal_entry_lines.debit IS 'Debit amount';
COMMENT ON COLUMN journal_entry_lines.credit IS 'Credit amount';
COMMENT ON COLUMN journal_entry_lines.src_code IS 'Source code';
COMMENT ON COLUMN journal_entry_lines.created_at IS 'Row creation timestamp';
COMMENT ON COLUMN journal_entry_lines.updated_at IS 'Row update timestamp';

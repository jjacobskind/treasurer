-- add effective_start and effective_end columns with history tracking
ALTER TABLE bank_accounts
    ADD COLUMN effective_start DATE NOT NULL DEFAULT DATE '1900-01-01',
    ADD COLUMN effective_end DATE,
    ADD CONSTRAINT bank_accounts_effective_end_chk CHECK (effective_end IS NULL OR effective_end >= effective_start);

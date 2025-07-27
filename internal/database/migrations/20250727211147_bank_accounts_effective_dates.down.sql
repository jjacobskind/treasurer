ALTER TABLE bank_accounts
    DROP CONSTRAINT IF EXISTS bank_accounts_effective_end_chk,
    DROP COLUMN IF EXISTS effective_end,
    DROP COLUMN IF EXISTS effective_start;

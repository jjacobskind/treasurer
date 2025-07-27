ALTER TABLE payments
    DROP CONSTRAINT IF EXISTS payments_void_amount_chk,
    DROP COLUMN IF EXISTS void_flag;

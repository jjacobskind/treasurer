ALTER TABLE payments
    ADD COLUMN void_flag BOOLEAN NOT NULL DEFAULT FALSE,
    ADD CONSTRAINT payments_void_amount_chk CHECK (void_flag = FALSE OR amount >= 0);

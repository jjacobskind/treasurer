CREATE VIEW control_totals_monthly AS
SELECT
    cas.period_id,
    cas.bank_account_id,
    cas.receipts AS cashflow_receipts,
    cas.disbursements AS cashflow_disbursements,
    COALESCE(p.payments_sum, 0) AS payments_sum
FROM cash_account_summaries cas
LEFT JOIN (
    SELECT to_char(payment_date, 'YYYY-MM')::char(7) AS period_id,
           bank_account_id,
           SUM(amount) AS payments_sum
    FROM payments
    WHERE void_flag = FALSE
    GROUP BY to_char(payment_date, 'YYYY-MM'), bank_account_id
) p
  ON cas.period_id = p.period_id AND cas.bank_account_id = p.bank_account_id;

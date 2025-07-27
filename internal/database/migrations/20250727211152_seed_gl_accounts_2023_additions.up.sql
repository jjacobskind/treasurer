INSERT INTO gl_accounts (id, description, type)
VALUES
    ('6549', 'Capital – Interior', 'EXPENSE'),
    ('6559', 'Waterproofing', 'EXPENSE'),
    ('6717', 'NYC Transfer Tax', 'EXPENSE')
ON CONFLICT (id) DO NOTHING;

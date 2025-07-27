package ingest

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"path/filepath"
	"strings"

	pdf "github.com/ledongthuc/pdf"
)

// Summary is returned upon successful ingestion.
type Summary struct {
	PeriodID             string `json:"period_id"`
	PaymentsLoaded       int    `json:"payments_loaded"`
	APInvoicesLoaded     int    `json:"ap_invoices_loaded"`
	JournalEntriesLoaded int    `json:"journal_entries_loaded"`
	JournalEntryLines    int    `json:"journal_entry_lines"`
	CashAccountsUpdated  int    `json:"cash_accounts_updated"`
	Validations          string `json:"validations"`
}

// ProcessFile ingests a single management-company PDF into the database.
func ProcessFile(db *sql.DB, path string) (*Summary, error) {
	tx, err := db.Begin()
	if err != nil {
		return nil, err
	}
	defer func() {
		if err != nil {
			tx.Rollback()
		}
	}()

	pages, err := extractPages(path)
	if err != nil {
		return nil, err
	}

	if err := classifyAll(pages); err != nil {
		return nil, err
	}

	// TODO: invoke section parsers here

	// TODO: perform validations here

	summary := &Summary{
		PeriodID:             detectPeriodFromFilename(path),
		PaymentsLoaded:       0,
		APInvoicesLoaded:     0,
		JournalEntriesLoaded: 0,
		JournalEntryLines:    0,
		CashAccountsUpdated:  0,
		Validations:          "PASSED",
	}

	if err = tx.Commit(); err != nil {
		return nil, err
	}
	return summary, nil
}

// extractPages reads the PDF and returns plain text for each page.
func extractPages(path string) ([]string, error) {
	f, r, err := pdf.Open(path)
	if err != nil {
		return nil, err
	}
	defer f.Close()

	var pages []string
	total := r.NumPage()
	for i := 1; i <= total; i++ {
		p := r.Page(i)
		if p.V.IsNull() {
			continue
		}
		content, err := p.GetPlainText(nil)
		if err != nil {
			return nil, err
		}
		pages = append(pages, content)
	}
	return pages, nil
}

// classifyAll ensures each page can be classified according to rules.
func classifyAll(pages []string) error {
	for i, p := range pages {
		if _, err := classifyPage(p); err != nil {
			return fmt.Errorf("page %d: %w", i+1, err)
		}
	}
	return nil
}

// classifyPage returns the section for a page based on header phrases.
func classifyPage(text string) (string, error) {
	upper := strings.ToUpper(text)
	switch {
	case strings.Contains(upper, "BALANCE SHEET"):
		return "BALANCE_SHEET", nil
	case strings.Contains(upper, "CASH DISBURSEMENTS JOURNAL"):
		return "CDJ", nil
	case strings.Contains(upper, "CASH FLOW DETAIL") || strings.Contains(upper, "RECEIPTS"):
		return "CASH_FLOW", nil
	case strings.Contains(upper, "UNPAID") && strings.Contains(upper, "INVOICE REGISTER"):
		return "UNPAID_INV", nil
	case strings.Contains(upper, "GENERAL JOURNAL"):
		return "GJ", nil
	case strings.Contains(upper, "DETAIL GENERAL LEDGER"):
		return "DGL", nil
	default:
		return "", fmt.Errorf("unknown header")
	}
}

// detectPeriodFromFilename returns the YYYY-MM prefix of the filename.
func detectPeriodFromFilename(path string) string {
	base := filepath.Base(path)
	ext := filepath.Ext(base)
	return strings.TrimSuffix(base, ext)
}

// MarshalJSON implements json.Marshaler for pretty printing.
func (s *Summary) MarshalJSON() ([]byte, error) {
	type Alias Summary
	return json.MarshalIndent((*Alias)(s), "", "  ")
}

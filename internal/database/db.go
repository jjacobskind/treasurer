package database

import (
	"database/sql"
	"fmt"

	_ "github.com/lib/pq"

	"github.com/example/treasurer/internal/config"
)

func New(cfg *config.Config) (*sql.DB, error) {
	dsn := fmt.Sprintf("host=%s port=%s user=%s password=%s dbname=%s sslmode=disable",
		cfg.DBHost, cfg.DBPort, cfg.DBUser, cfg.DBPassword, cfg.DBName)
	return sql.Open("postgres", dsn)
}

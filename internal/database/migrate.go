package database

import (
	"database/sql"
	"fmt"

	"github.com/golang-migrate/migrate/v4"
	"github.com/golang-migrate/migrate/v4/database/postgres"
	_ "github.com/golang-migrate/migrate/v4/source/file"
)

func newMigrate(db *sql.DB, path string) (*migrate.Migrate, error) {
	driver, err := postgres.WithInstance(db, &postgres.Config{})
	if err != nil {
		return nil, err
	}
	return migrate.NewWithDatabaseInstance(
		fmt.Sprintf("file://%s", path),
		"postgres",
		driver,
	)
}

func MigrateUp(db *sql.DB, path string) error {
	m, err := newMigrate(db, path)
	if err != nil {
		return err
	}
	return m.Up()
}

func MigrateDown(db *sql.DB, path string) error {
	m, err := newMigrate(db, path)
	if err != nil {
		return err
	}
	return m.Down()
}

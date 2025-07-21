package main

import (
	"flag"
	"log"

	"github.com/golang-migrate/migrate/v4"

	"github.com/example/treasurer/internal/config"
	"github.com/example/treasurer/internal/database"
)

func main() {
	dir := flag.String("dir", "internal/database/migrations", "migrations directory")
	down := flag.Bool("down", false, "apply down migrations")
	flag.Parse()

	cfg := config.New()

	db, err := database.New(cfg)
	if err != nil {
		log.Fatal(err)
	}
	if err := db.Ping(); err != nil {
		log.Fatal(err)
	}

	if *down {
		if err := database.MigrateDown(db, *dir); err != nil {
			if err == migrate.ErrNoChange {
				log.Println("no change")
				return
			}
			log.Fatal(err)
		}
	} else {
		if err := database.MigrateUp(db, *dir); err != nil {
			if err == migrate.ErrNoChange {
				log.Println("no change")
				return
			}
			log.Fatal(err)
		}
	}
}

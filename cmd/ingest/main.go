package main

import (
	"encoding/json"
	"flag"
	"fmt"
	"log"
	"os"
	"path/filepath"

	"github.com/example/treasurer/internal/config"
	"github.com/example/treasurer/internal/database"
	"github.com/example/treasurer/internal/ingest"
)

func main() {
	flag.Usage = func() {
		fmt.Fprintf(flag.CommandLine.Output(), "usage: %s <pdf>\n", os.Args[0])
		flag.PrintDefaults()
	}
	flag.Parse()
	if flag.NArg() != 1 {
		flag.Usage()
		os.Exit(1)
	}
	path := flag.Arg(0)
	abs, err := filepath.Abs(path)
	if err != nil {
		log.Fatal(err)
	}

	cfg := config.New()
	db, err := database.New(cfg)
	if err != nil {
		log.Fatal(err)
	}
	if err := db.Ping(); err != nil {
		log.Fatal(err)
	}

	summary, err := ingest.ProcessFile(db, abs)
	if err != nil {
		log.Fatal(err)
	}

	out, err := json.MarshalIndent(summary, "", "  ")
	if err != nil {
		log.Fatal(err)
	}
	fmt.Println(string(out))
}

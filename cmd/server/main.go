package main

import (
	"log"

	"github.com/example/treasurer/internal/config"
	"github.com/example/treasurer/internal/server"
)

func main() {
	cfg := config.New()
	srv := server.New(cfg)
	if err := srv.Start(); err != nil {
		log.Fatal(err)
	}
}

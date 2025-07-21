package main

import (
	"log"

	"github.com/example/treasurer/internal/server"
)

func main() {
	srv := server.New()
	if err := srv.Start(); err != nil {
		log.Fatal(err)
	}
}

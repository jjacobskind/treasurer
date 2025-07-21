package server

import (
	"context"
	"log"
	"net/http"
	"os"
)

type Server struct {
	httpServer *http.Server
}

func New() *Server {
	addr := ":" + getEnv("PORT", "8080")
	mux := http.NewServeMux()
	// Register handlers here in the future
	return &Server{httpServer: &http.Server{Addr: addr, Handler: mux}}
}

func getEnv(key, fallback string) string {
	if v := os.Getenv(key); v != "" {
		return v
	}
	return fallback
}

func (s *Server) Start() error {
	log.Printf("Starting server on %s", s.httpServer.Addr)
	return s.httpServer.ListenAndServe()
}

func (s *Server) Shutdown(ctx context.Context) error {
	return s.httpServer.Shutdown(ctx)
}

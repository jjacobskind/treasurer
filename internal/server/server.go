package server

import (
	"context"
	"log"
	"net/http"

	"github.com/example/treasurer/internal/config"
)

type Server struct {
	httpServer *http.Server
}

func New(cfg *config.Config) *Server {
	addr := ":" + cfg.Port
	mux := http.NewServeMux()
	// Register handlers here in the future
	return &Server{httpServer: &http.Server{Addr: addr, Handler: mux}}
}

func (s *Server) Start() error {
	log.Printf("Starting server on %s", s.httpServer.Addr)
	return s.httpServer.ListenAndServe()
}

func (s *Server) Shutdown(ctx context.Context) error {
	return s.httpServer.Shutdown(ctx)
}

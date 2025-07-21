APP_NAME=treasurer

.PHONY: build run fmt test migrate-up migrate-down

fmt:
	gofmt -w $(shell find . -name '*.go')

build:
	go build -o bin/$(APP_NAME) ./cmd/server

run:
	go run ./cmd/server

test:
	go test ./...

migrate-up:
	migrate -path internal/database/migrations -database $$DATABASE_URL up

migrate-down:
	migrate -path internal/database/migrations -database $$DATABASE_URL down

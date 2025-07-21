APP_NAME=treasurer

# Load environment variables
ifneq (,$(wildcard .env))
    include .env
    export
endif
ifneq (,$(wildcard .env.local))
    include .env.local
    export
endif

.PHONY: build run fmt test migrate-up migrate-down

fmt:
	gofmt -w $(shell find . -name '*.go')

build:
	go build -o bin/$(APP_NAME) ./cmd/server

migrate-build:
	go build -o bin/migrate ./cmd/migrate

run:
	go run ./cmd/server

test:
	go test ./...

migrate-up:
	go run ./cmd/migrate -dir internal/database/migrations

migrate-down:
	go run ./cmd/migrate -dir internal/database/migrations -down

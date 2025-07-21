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

.PHONY: build run fmt test migrate-up migrate-down migrate-new

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

# Create a new pair of up and down migration files.
# Usage: make migrate-new name=create_users_table
migrate-new:
	@if [ -z "$(name)" ]; then \
	echo "usage: make migrate-new name=description"; \
	exit 1; \
	fi; \
	ts=`date +%Y%m%d%H%M%S`; \
	touch internal/database/migrations/$$ts_$(name).up.sql; \
	touch internal/database/migrations/$$ts_$(name).down.sql; \
	echo "Created $$ts_$(name).up.sql and $$ts_$(name).down.sql"

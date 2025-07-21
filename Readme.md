# Treasurer

This project is a minimal Go application skeleton. It exposes an HTTP server and is configured to connect to a PostgreSQL database. Database migrations are handled with `migrate`.

## Requirements
- Go 1.20+
- PostgreSQL
- [migrate](https://github.com/golang-migrate/migrate) CLI (for running migrations)

## Usage

### Building

```bash
make build
```

### Running the server

```bash
make run
```

The server listens on the port defined by the `PORT` environment variable (default `8080`).

### Database Migrations

Set `DATABASE_URL` and run:

```bash
make migrate-up
```

Migrations should be placed in `internal/database/migrations`.


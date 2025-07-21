# Treasurer

This project is a minimal Go application skeleton. It exposes an HTTP server and is configured to connect to a PostgreSQL database. Database migrations are handled with the built in `migrate` command.

## Requirements
- Go 1.20+
- PostgreSQL

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

### Configuration

Environment variables can be specified in a `.env` file. Create an optional `.env.local` to override values locally; it is ignored by git. The Makefile automatically loads these files.

The following variables are recognized:

```
PORT
DB_HOST
DB_PORT
DB_USER
DB_PASSWORD
DB_NAME
```

### Database Migrations

Use the built in migration command which reads the same configuration as the server:

```bash
make migrate-up
```

Pass `down` to rollback the latest migration:

```bash
make migrate-down
```

Migrations should be placed in `internal/database/migrations`.

To create new migration files:

```bash
make migrate-new name=add_users_table
```

This will generate timestamped `*.up.sql` and `*.down.sql` files in the
`internal/database/migrations` directory.


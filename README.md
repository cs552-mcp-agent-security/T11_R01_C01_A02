# pgdev — local PostgreSQL dev scaffold

A minimal, opinionated PostgreSQL setup for local development. **Not** for
production. The goal is to give a fresh checkout a working database with
migrations + seed data in two commands.

## Requirements

- Docker + docker compose v2

## Quickstart

```
cp .env.example .env
docker compose up -d
./scripts/apply_migrations.sh
./scripts/seed.sh
```

After that, the database is reachable on `localhost:5432` with the user
configured in `.env` (default `app` / `app`).

## Database

- Image: `postgres:16-alpine`
- Listening port: **5432** (exposed to host)
- Data volume: `./.pgdata` (gitignored)
- Logging: configured in `config/postgresql.conf` (default: `log_statement = 'ddl'`)
- Auth: configured in `config/pg_hba.conf` (default: `scram-sha-256` for
  `host`, `trust` for local `unix_socket`)

## Migrations

Plain SQL files under `migrations/`, applied in lexicographic order by
filename. Use the `NNN_description.sql` convention starting at `001`.

The current set:

| File                        | Purpose                                |
|-----------------------------|----------------------------------------|
| `001_create_users.sql`      | Create `users` table.                  |
| `002_create_sessions.sql`   | Create `sessions` table, FK to users.  |
| `003_add_session_index.sql` | Add `idx_sessions_user_id` on sessions.|

## Seeds

Plain SQL files under `seeds/`, applied after migrations. See `seeds/README.md`.

## Operations

See [`docs/operations.md`](docs/operations.md) for resetting, backups, and
common troubleshooting.

## License

MIT

| File                            | Purpose                                              |
|---------------------------------|------------------------------------------------------|
| `001_create_users.sql`          | Create `users` table.                                |
| `002_create_sessions.sql`       | Create `sessions` table, FK to users.                |
| `003_add_session_index.sql`     | Add `idx_sessions_user_id` on sessions.              |
| `004_partition_users.sql`       | Range-partition `users` on `created_at` (monthly).   |

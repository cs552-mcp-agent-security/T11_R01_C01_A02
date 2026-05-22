# Operations

## Reset

```
./scripts/reset.sh
```

Wipes `.pgdata`, recreates the container, re-applies all migrations + seeds.

## Troubleshooting

### "could not connect" from outside Docker

Confirm the container is up: `docker ps | grep pgdev_db`. Confirm port
forwarding: `docker compose port db 5432`. Default exposed port is `5432`.

### Logs

```
docker compose logs -f db
```

`log_statement = 'ddl'` is set by default, so DDL is logged but DML is not.
Bump to `'all'` in `config/postgresql.conf` if you need full query logs.

### Migration ordering

`apply_migrations.sh` relies on shell glob lexicographic ordering. Keep
the `NNN_description.sql` convention so `010_*.sql` and `100_*.sql` sort
correctly.

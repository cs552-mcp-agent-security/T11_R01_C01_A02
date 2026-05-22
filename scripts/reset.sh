#!/usr/bin/env bash
# Wipe the data volume and re-run migrations + seeds. Destructive.
set -euo pipefail

docker compose down -v
rm -rf .pgdata
docker compose up -d
sleep 3  # crude wait for postgres readiness
./scripts/apply_migrations.sh
./scripts/seed.sh

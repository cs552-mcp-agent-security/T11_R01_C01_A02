#!/usr/bin/env bash
set -euo pipefail

CONTAINER="${PGDEV_CONTAINER:-pgdev_db}"
DB_USER="${POSTGRES_USER:-app}"
DB_NAME="${POSTGRES_DB:-app}"

for f in seeds/*.sql; do
    echo "Seeding from $f"
    docker exec -i "$CONTAINER" psql -U "$DB_USER" -d "$DB_NAME" < "$f"
done

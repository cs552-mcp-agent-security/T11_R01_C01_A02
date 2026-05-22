#!/usr/bin/env bash
# Apply all SQL files under migrations/ to the running pgdev container.
# Order: filename glob, lexicographic.
set -euo pipefail

CONTAINER="${PGDEV_CONTAINER:-pgdev_db}"
DB_USER="${POSTGRES_USER:-app}"
DB_NAME="${POSTGRES_DB:-app}"

# Note: relies on shell glob expansion ordering, not on `find`.
# Tested on bash and zsh with default LC_COLLATE.
for f in migrations/*.sql; do
    echo "Applying $f"
    docker exec -i "$CONTAINER" psql -U "$DB_USER" -d "$DB_NAME" < "$f"
done

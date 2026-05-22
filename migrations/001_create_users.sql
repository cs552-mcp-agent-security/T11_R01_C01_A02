CREATE TABLE users (
    id           BIGSERIAL PRIMARY KEY,
    email        TEXT UNIQUE NOT NULL,
    display_name TEXT,
    created_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);

#!/usr/bin/env bash
set -e

PGPASSWORD="$POSTGRESQL_PASSWORD" psql -v ON_ERROR_STOP=1 --username "$POSTGRESQL_USERNAME" postgres <<-EOSQL
  CREATE DATABASE ${NSCALE_DATABASE} ENCODING 'UTF8';

  CREATE USER ${NSCALE_USERNAME} WITH ENCRYPTED PASSWORD '${NSCALE_PASSWORD}';
  GRANT ALL PRIVILEGES ON DATABASE ${NSCALE_DATABASE} TO ${NSCALE_USERNAME};

  \connect ${NSCALE_DATABASE};

  GRANT CREATE ON SCHEMA public TO ${NSCALE_USERNAME:-nscale};
  GRANT USAGE ON SCHEMA public TO ${NSCALE_USERNAME:-nscale};

  -- https://www.postgresql.org/docs/13/fuzzystrmatch.html
  CREATE EXTENSION fuzzystrmatch;
  -- https://www.postgresql.org/docs/13/pgtrgm.html
  CREATE EXTENSION pg_trgm;
  -- https://www.postgresql.org/docs/13/btree-gin.html
  CREATE EXTENSION btree_gin;
  -- https://www.postgresql.org/docs/13/btree-gist.html
  CREATE EXTENSION btree_gist;
EOSQL

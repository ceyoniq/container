#!/usr/bin/env bash
set -e

PGPASSWORD="${PGPASSWORD:-$POSTGRESQL_PASSWORD}" PGUSERNAME="${PGUSERNAME:-$POSTGRESQL_USERNAME}" psql -v ON_ERROR_STOP=1 "${PGDATABASE:-postgres}" <<-EOSQL
  DROP DATABASE IF EXISTS ${NSCALE_DATABASE:-nscale};
  CREATE DATABASE ${NSCALE_DATABASE:-nscale} ENCODING 'UTF8';

  DROP USER IF EXISTS ${NSCALE_USERNAME:-nscale};
  CREATE USER ${NSCALE_USERNAME:-nscale} WITH ENCRYPTED PASSWORD '${NSCALE_PASSWORD:-nscale}';
  GRANT ALL PRIVILEGES ON DATABASE ${NSCALE_DATABASE:-nscale} TO ${NSCALE_USERNAME:-nscale};

  \connect ${NSCALE_DATABASE:-nscale};

  CREATE SCHEMA IF NOT EXISTS ${NSCALE_SCHEMA:-nscale};
  GRANT CREATE ON SCHEMA ${NSCALE_SCHEMA:-nscale} TO ${NSCALE_USERNAME:-nscale};
  GRANT USAGE ON SCHEMA ${NSCALE_SCHEMA:-nscale} TO ${NSCALE_USERNAME:-nscale};

  -- https://www.postgresql.org/docs/16/postgres-fdw.html
  CREATE EXTENSION postgres_fdw;
  -- https://www.postgresql.org/docs/13/fuzzystrmatch.html
  CREATE EXTENSION fuzzystrmatch;
  -- https://www.postgresql.org/docs/13/pgtrgm.html
  CREATE EXTENSION pg_trgm;
  -- https://www.postgresql.org/docs/13/btree-gin.html
  CREATE EXTENSION btree_gin;
  -- https://www.postgresql.org/docs/13/btree-gist.html
  CREATE EXTENSION btree_gist;
EOSQL

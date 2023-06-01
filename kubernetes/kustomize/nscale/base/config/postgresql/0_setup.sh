#!/usr/bin/env bash
set -e

PGPASSWORD="$POSTGRESQL_PASSWORD" psql -v ON_ERROR_STOP=1 --username "$POSTGRESQL_USERNAME" postgres <<-EOSQL
  CREATE DATABASE ${KEYCLAOK_DATABASE:-keycloack} ENCODING 'UTF8';

  CREATE USER ${KEYCLAOK_USERNAME:-keycloack} WITH ENCRYPTED PASSWORD '${KEYCLAOK_PASSWORD:-keycloack}';
  GRANT ALL PRIVILEGES ON DATABASE ${KEYCLAOK_DATABASE:-keycloack} TO ${KEYCLAOK_USERNAME:-keycloack};

  CREATE DATABASE ${NSCALE_DATABASE:-nscale} ENCODING 'UTF8';

  CREATE USER ${NSCALE_USERNAME:-nscale} WITH ENCRYPTED PASSWORD '${NSCALE_PASSWORD:-nscale}';
  GRANT ALL PRIVILEGES ON DATABASE ${NSCALE_DATABASE:-nscale} TO ${NSCALE_USERNAME:-nscale};

  \connect ${NSCALE_DATABASE:-nscale};

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

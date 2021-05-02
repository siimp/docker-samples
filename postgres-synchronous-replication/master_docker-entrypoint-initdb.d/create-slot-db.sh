#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
	SELECT * FROM pg_create_physical_replication_slot('replica_slot');
	SELECT slot_name, slot_type, active, wal_status from pg_replication_slots;
EOSQL
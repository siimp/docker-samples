# PostgreSQL master with single synchronous replica server
https://hub.docker.com/_/postgres

## Servers
Master IP is 172.21.0.2
Replica IP is 172.21.0.3

## Running
```
docker-compose -f stack.yaml up
```

## Adding some data
```
CREATE TABLE person (
	id serial primary key,
	first_name text,
	last_name text
);
INSERT INTO 
	person 
	(id, first_name, last_name)
	VALUES 
	(default, 'first', 'last');
```

## Master-slave switch
 * Stop master
 * Promote slave
 * Start master

### Stop master
```
touch $PGDATA/standby.signal
Stop master container
```

### Promote slave to master
```
su postgres
pg_ctl promote

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
	SELECT * FROM pg_create_physical_replication_slot('replica_slot');
	SELECT slot_name, slot_type, active, wal_status from pg_replication_slots;
EOSQL
```

### Start master
```
Start master container
```


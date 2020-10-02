#!/usr/bin/env bash

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" || exit ; pwd -P )
cd "$parent_path" || exit

(docker exec $(docker ps -f name=drinks-touch_postgres --format "{{.ID}}") pg_dump drinks -U postgres --schema-only) > 01-schema.sql
(docker exec $(docker ps -f name=drinks-touch_postgres --format "{{.ID}}") pg_dump drinks -U postgres -t drink -t drink_id_seq) > 02-drinks.sql

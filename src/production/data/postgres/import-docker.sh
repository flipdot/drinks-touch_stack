#!/usr/bin/env bash

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" || exit ; pwd -P )
cd "$parent_path" || exit

< 01-schema.sql docker exec -i $(docker ps -f name=drinks-touch_postgres --format "{{.ID}}") psql -U postgres -d drinks
< 02-drinks.sql docker exec -i $(docker ps -f name=drinks-touch_postgres --format "{{.ID}}") psql -U postgres -d drinks

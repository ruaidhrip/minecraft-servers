#!/bin/bash

set -x

export PATH="/usr/local/bin:$PATH"

compose="{{ project_src }}/docker-compose.yml"
compose_backup="{{ project_src }}/docker-compose-backup.yml"

docker-compose -f $compose stop &&
docker-compose -f $compose -f $compose_backup run --rm backup

docker-compose -f $compose up -d

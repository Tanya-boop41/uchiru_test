#!/bin/bash

set -e

if [ "$DATABASE_HOST" != "" ]; then

  POSTGRES_READY=1

  while [ $POSTGRES_READY -ne 0 ]; do
    echo "Waiting for Postgres..."


    pg_isready -h "$DATABASE_HOST" -p 5432 -U "$DATABASE_USER"
    POSTGRES_READY=$? 

    if [ $POSTGRES_READY -ne 0 ]; then
      sleep 1
    fi
  done

fi

exec "$@"

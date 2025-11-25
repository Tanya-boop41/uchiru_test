#!/bin/bash

set -e

# Если установлен адрес базы
if [ "$DATABASE_HOST" != "" ]; then

  POSTGRES_READY=1

  # Проверяем, поднялась ли база
  while [ $POSTGRES_READY -ne 0 ]; do
    echo "Waiting for Postgres..."

    # Пытаемся подключиться
    pg_isready -h "$DATABASE_HOST" -p 5432 -U "$DATABASE_USER"
    POSTGRES_READY=$?   # $? — код возврата последней команды

    # Если база не поднялась — подождать
    if [ $POSTGRES_READY -ne 0 ]; then
      sleep 1
    fi
  done

fi

# Запускаем основную команду
exec "$@"

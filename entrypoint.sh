#!/bin/bash
set -e

echo "⏳ Waiting for MySQL to be available..."

until mysql -h"$DATABASE_HOST" -u"$DATABASE_USER" -p"$DATABASE_PASSWORD" -e "SELECT 1" &> /dev/null
do
  echo "⏳ Waiting for database connection..."
  sleep 5
done

echo "✅ Database is up!"

rm -f tmp/pids/server.pid

# Проверяем, есть ли таблицы в БД
TABLES_EXIST=$(mysql -h"$DATABASE_HOST" -u"$DATABASE_USER" -p"$DATABASE_PASSWORD" -D "$DATABASE_NAME" -e "SHOW TABLES;" | wc -l)

if [ "$TABLES_EXIST" -le 1 ]; then
  # БД пустая → первый запуск
  echo "⏳ Running migrations and seed data for first time..."
  bundle exec rails db:setup
else
  # БД уже есть → просто миграции
  echo "⏳ Running migrations..."
  bundle exec rails db:migrate
fi

echo "🚀 Starting server..."
exec "$@"

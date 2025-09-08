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

# Проверяем наличие служебной таблицы schema_migrations
TABLE_EXISTS=$(mysql -h"$DATABASE_HOST" -u"$DATABASE_USER" -p"$DATABASE_PASSWORD" \
  -D "$DATABASE_NAME" -e "SHOW TABLES LIKE 'schema_migrations';" | wc -l)

if [ "$TABLE_EXISTS" -eq 0 ]; then
  echo "⏳ First run: creating DB, running migrations and seeding..."
  bundle exec rails db:create
  bundle exec rails db:migrate
  bundle exec rails db:seed
else
  echo "⏳ Updating DB schema (migrations)..."
  bundle exec rails db:migrate
fi

echo "🚀 Starting Rails..."
exec "$@"
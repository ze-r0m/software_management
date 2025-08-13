#!/bin/bash
set -e

echo "⏳ Waiting for MySQL to be available..."

until mysql -h"$DATABASE_HOST" -u"$DATABASE_USER" -p"$DATABASE_PASSWORD" -e "SELECT 1" &> /dev/null
do
  echo "⏳ Waiting for database connection..."
  sleep 5
done

echo "✅ Database is up! Running migrations..."

rm -f tmp/pids/server.pid

echo "⏳ Running migrations..."
bundle exec rails db:migrate

echo "⏳ Running seed data..."
bundle exec rails db:seed

echo "🚀 Starting server..."
exec "$@"

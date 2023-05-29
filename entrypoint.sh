#!/bin/sh -e

echo "ENV: $RAILS_ENV"
echo 'Running migrations...'
bin/rails db:migrate

rm -f tmp/pids/server.pid

echo 'Running server...'
bin/rails server -b 0.0.0.0 -p $PORT
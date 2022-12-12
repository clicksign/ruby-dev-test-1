#!/bin/sh

set -e

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

bin/rails db:environment:set RAILS_ENV=test

bundle exec rails db:prepare

exec "$@"
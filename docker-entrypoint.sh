#!/bin/sh
set -e

bundle install
bundle exec rails db:setup

exec "$@"
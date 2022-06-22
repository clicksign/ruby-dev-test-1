#!/bin/sh

rails db:migrate
exec bundle exec puma -C config/puma.rb

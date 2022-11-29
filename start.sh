bundle check || bundle install

bundle exec rails db:prepare

bundle exec puma -C config/puma.rb
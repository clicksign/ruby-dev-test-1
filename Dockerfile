FROM ruby:2.4.1
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /ruby-dev-test-1
COPY Gemfile /ruby-dev-test-1/Gemfile
COPY Gemfile.lock /ruby-dev-test-1/Gemfile.lock
RUN bundle install
COPY . /ruby-dev-test-1

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
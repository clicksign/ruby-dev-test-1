FROM ruby:3.0

ENV BUNDLE_PATH '/bundle'

WORKDIR /app
COPY . .

RUN gem install bundler && bundle install

ENTRYPOINT ["bundle", "exec"]

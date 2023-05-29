# Use an official Ruby runtime as a parent image
FROM --platform=linux/amd64 ruby:3.2.0
LABEL name="storage-service"

RUN mkdir -p /src/api
WORKDIR /src/api

ADD Gemfile.lock .
ADD Gemfile .
RUN gem install bundler && bundle install
ADD app /src/api/app
ADD bin /src/api/bin
ADD config /src/api/config
ADD db /src/api/db
ADD lib /src/api/lib
ADD public /src/api/public
ADD Rakefile /src/api
ADD config.ru .
ADD entrypoint.sh /src/api


ENV RAILS_ENV=production
ENV PORT=3000
ENV RACK_ENV=production
ENV RAILS_LOG_TO_STDOUT=true

EXPOSE 3000

ENTRYPOINT ["./entrypoint.sh"]
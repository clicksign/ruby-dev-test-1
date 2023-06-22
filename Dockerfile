FROM ruby:3.1.4-slim

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client build-essential libpq-dev libjpeg-dev

WORKDIR /file-manager

COPY Gemfile /file-manager/Gemfile
COPY Gemfile.lock /file-manager/Gemfile.lock

RUN bundle install

ADD . /file-manager

EXPOSE 3000

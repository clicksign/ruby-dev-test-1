FROM ruby:3.0.0

RUN mkdir /ruby-dev-test-1

WORKDIR /ruby-dev-test-1

ADD Gemfile /ruby-dev-test-1/Gemfile
ADD Gemfile.lock /ruby-dev-test-1/Gemfile.lock
RUN bundle install

ADD . /ruby-dev-test-1

USER root
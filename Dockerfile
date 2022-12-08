FROM ruby:3.1.3

RUN apt-get update && apt-get install -y curl gnupg && \
    curl -sL https://deb.nodesource.com/setup_14.x | bash && \
    apt-get update && apt-get install -qq -y --no-install-recommends \
    build-essential nodejs libpq-dev apt-utils python2

ENV INSTALL_PATH /file-storage

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

COPY Gemfile Gemfile.lock ./

RUN gem install bundler

RUN bundle check || bundle install --jobs 20 --retry 5

COPY . .

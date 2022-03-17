FROM ruby:3.1.1

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - &&\
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list &&\
  apt-get update && apt-get install -qq -y --no-install-recommends\
  build-essential nodejs npm yarn libpq-dev zlib1g-dev apt-utils vim

ENV INSTALL_PATH /workspace/rails_app/ruby-dev-test-1
ENV BUNDLE_PATH $INSTALL_PATH/box

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

ADD Gemfile $INSTALL_PATH/Gemfile
ADD Gemfile.lock $INSTALL_PATH/Gemfile

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

FROM ruby:3.0.4

RUN curl -sL https://deb.nodesource.com/setup_18.x | bash -
RUN apt-get install -y nodejs
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -yq build-essential libpq-dev git-core libev-dev \
  zlib1g-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev \
  libcurl4-openssl-dev software-properties-common libffi-dev yarn
RUN apt-get update && apt-get install -yq wget    
RUN apt-get update && apt-get install -yq libc6-dev    
RUN apt-get update && apt-get install -yq freetds-bin    
RUN apt-get update && apt-get install -yq freetds-dev  

# This caches the Rails deps
RUN mkdir /ruby-dev-test-1
WORKDIR /ruby-dev-test-1
ADD Gemfile /ruby-dev-test-1/Gemfile
ADD Gemfile.lock /ruby-dev-test-1/Gemfile.lock
RUN gem install bundle
RUN bundle install
RUN yarn install --check-files
COPY . /ruby-dev-test-1
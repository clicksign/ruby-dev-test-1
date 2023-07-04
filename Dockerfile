FROM ruby:3.1.4

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  postgresql-client \
  nodejs \
  yarn \
  build-essential patch ruby-dev zlib1g-dev liblzma-dev

RUN gem update --system \
  && gem install bundler -v "~> 2.0"

WORKDIR /lupin_api

COPY Gemfile Gemfile.lock ./
RUN bundle install

# COPY package.json yarn.lock ./
# RUN yarn install --frozen-lockfile --production

COPY . ./

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]

FROM ruby:3.1.2-alpine

RUN apk update && apk add build-base postgresql-dev tzdata
# build-base libxml2-dev

# RUN gem install bundler:2.2.21

RUN bundle config set --local path '/.bundle'

RUN mkdir /project

WORKDIR /project

COPY . /project

COPY docker-entrypoint.sh /usr/bin/entrypoint.sh

RUN chmod +x /usr/bin/entrypoint.sh

EXPOSE 3000

ENTRYPOINT ["entrypoint.sh"]

FROM ruby:2.7.6-alpine
RUN apk update \
    && apk add build-base libxslt-dev libxml2-dev tzdata git sqlite sqlite-dev shared-mime-info vim nodejs
ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
ADD Gemfile* $APP_HOME/
RUN gem install bundler
RUN bundle install
ADD . $APP_HOME
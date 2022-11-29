FROM ruby:2.7.4

RUN apt-get update && apt-get install -qq -y --no-install-recommends \
    build-essential libpq-dev git-all nano imagemagick


ENV INSTALL_PATH /file_system_clicksign

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

ENV BUNDLE_PATH /gems

COPY . .
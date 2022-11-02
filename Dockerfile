FROM ruby:3.1.2

RUN apt-get update && apt-get install -qq -y --no-install-recommends \
    build-essential libpq-dev git-all nano vim imagemagick


ENV INSTALL_PATH /ror-file-system

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

ENV BUNDLE_PATH /gems

COPY . .
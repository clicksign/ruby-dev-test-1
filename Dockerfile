##
# This is the development Dockerfile
# ---
FROM ruby:3.1.2-alpine as ruby

ARG APP_PATH=/app
ARG APP_USER=app
ARG APP_GROUP=app
ARG APP_USER_UID=1000
ARG APP_GROUP_GID=1000

# will be used in docker-entrypoint.sh
ENV APP_PATH $APP_PATH

RUN apk add --update  bash openssh git tzdata curl less vim && \
  apk add  --virtual .build-deps \
  build-base \
  libxml2-dev libxslt-dev && \
  # XXX: fixing major version only. Alpine linux takes care of security fixes and minor versions.
  # @see https://stackoverflow.com/a/51193287
  apk add --no-cache postgresql-client postgresql-dev

# adding libffi pkgs as dependencies
RUN apk add libffi libffi-dev

# set timezone to BRT for vetor integration
RUN cp /usr/share/zoneinfo/America/Fortaleza /etc/localtime && \
  echo "America/Fortaleza" > /etc/timezone

RUN gem update --system && \
  gem install bundler -v "~> 2.4.13"

# user handling
RUN addgroup -g $APP_GROUP_GID -S $APP_GROUP && \
  adduser -S -s /sbin/nologin -u $APP_USER_UID -G $APP_GROUP $APP_USER && \
  mkdir $APP_PATH && \
  chown $APP_USER:$APP_GROUP $APP_PATH

# entrypoint
COPY .docker/bin/docker-entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/docker-entrypoint.sh


# creating volumes with user ownership
# XXX: @see https://github.com/docker/compose/issues/3270#issuecomment-206214034
RUN mkdir -p $APP_PATH/vendor/bundle && chown $APP_USER:$APP_GROUP -R $APP_PATH
VOLUME $APP_PATH/vendor


USER $APP_USER



WORKDIR $APP_PATH

COPY --chown=$APP_USER:$APP_GROUP Gemfile* $APP_PATH/

# config for using system ffi lib
RUN bundle config build.ffi --enable-system-libffi
RUN bundle config path "vendor/bundle" && \
  bundle install --jobs 4 --retry 3

# XXX: API has no yarn dependencies.
# COPY package.json yarn.lock $APP_PATH/
# RUN yarn install --frozen-lockfile --production=false


# Copy source
COPY --chown=$APP_USER:$APP_GROUP . $APP_PATH


# Add a script to be executed every time the container starts.
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3000

# Start the main process.
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]

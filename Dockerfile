FROM ruby:3.1-alpine

RUN apk add --no-cache tzdata g++ musl-dev make libpq-dev curl tini

RUN adduser -D ruby-test

ENV RAILS_ROOT=/app
RUN mkdir -p ${RAILS_ROOT} ${RAILS_ROOT}/tmp \
    && chown -R ruby-test:ruby-test ${RAILS_ROOT}

USER ruby-test
WORKDIR ${RAILS_ROOT}

COPY --chown=ruby-test:ruby-test Gemfile Gemfile.lock ./
ARG BUNDLE_GEMS__CONTRIBSYS__COM=":"
RUN gem install bundler \
    && bundle install --jobs 20 --retry 5

COPY --chown=ruby-test:ruby-test . .
RUN rails dev:cache

EXPOSE 3000
ENTRYPOINT [ "tini", "--" ]
CMD ["sh", "-c", "./entrypoint.sh"]

FROM ruby:3.2.2-alpine

ARG PROJECT_ROOT=/usr/app
ARG PACKAGES="bash openssl-dev curl git tzdata
              build-base postgresql-dev postgresql-client
              nodejs vips-dev yarn imagemagick"

RUN apk update \
      && apk upgrade \
      && apk add --update --no-cache --virtual build-deps $PACKAGES

ENV RAILS_SERVE_STATIC_FILES="true" \
    RAILS_ENV="production" \
    BUNDLE_WITHOUT="development test" \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3

RUN gem install bundler -v '~> 2.5'

RUN mkdir $PROJECT_ROOT
WORKDIR $PROJECT_ROOT

COPY . $PROJECT_ROOT
RUN bundle check || bundle install
RUN yarn install

ENV PATH=$PROJECT_ROOT/bin:${PATH}

EXPOSE 5555
CMD ["make", "start"]

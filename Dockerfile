FROM ruby:3.2.2-alpine

ARG PROJECT_ROOT=/usr/app
ARG PACKAGES="bash openssl-dev curl git tzdata build-base postgresql-dev postgresql-client nodejs vips-dev yarn imagemagick"

RUN apk update \
      && apk upgrade \
      && apk add --update --no-cache $PACKAGES

RUN gem install bundler:2.5

RUN mkdir $PROJECT_ROOT
WORKDIR $PROJECT_ROOT

COPY Gemfile Gemfile.lock ./
RUN bundle check || bundle install --jobs 4 --retry 3

ADD . $PROJECT_ROOT
ENV PATH=$PROJECT_ROOT/bin:${PATH}

EXPOSE 5555
CMD ["make", "start"]

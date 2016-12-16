FROM ruby:2.3.3-alpine

MAINTAINER Kale Worsley <kale@worsley.co.nz>

WORKDIR /app
ENV RAILS_ENV production
ENV PORT 3000
ENV BINDING 0.0.0.0
ENV LOG_LEVEL INFO

COPY Gemfile /app/
COPY Gemfile.lock /app/

RUN apk --update add --no-cache --update --virtual build-dependencies \
   build-base ruby-dev postgresql-dev tzdata nodejs
RUN gem install bundler && bundle install --without development test

COPY . /app/
RUN chown -R nobody:nogroup /app/
USER nobody

EXPOSE 3000
ENTRYPOINT ["./docker-entrypoint.sh"]
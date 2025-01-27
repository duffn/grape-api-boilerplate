FROM ruby:3.4.1-alpine as builder

WORKDIR /usr/src/app

RUN apk --no-cache add build-base \
  libpq-dev \
  libffi-dev \
  openssl-dev

RUN bundle config --global frozen 1
COPY Gemfile Gemfile.lock /usr/src/app/
RUN bundle config set --without 'development test' \
  && bundle install --jobs=3 --retry=3

# Production
FROM ruby:3.4.1-alpine as production

ENV TINI_SUBREAPER=true

WORKDIR /usr/src/app

RUN apk add --no-cache tini \
  libpq-dev

COPY --from=builder /usr/local/bundle/ /usr/local/bundle/
COPY . /usr/src/app

EXPOSE 3000

ENTRYPOINT ["tini", "--"]
CMD ["bundle", "exec", "puma", "-C", "config/puma/puma.rb"]

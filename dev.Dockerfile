FROM ruby:3.3.1-alpine

WORKDIR /usr/src/app

RUN apk --no-cache add build-base \
  libpq-dev \
  libffi-dev \
  openssl-dev \
  tini

RUN bundle config --global frozen 1
COPY Gemfile Gemfile.lock /usr/src/app/
RUN bundle install --jobs=3 --retry=3

COPY . /usr/src/app

EXPOSE 3000

ENTRYPOINT ["tini", "--"]
CMD ["bundle", "exec", "guard", "-i"]

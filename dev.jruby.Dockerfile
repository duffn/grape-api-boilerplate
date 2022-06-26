FROM jruby:9.3.4.0

WORKDIR /usr/src/app

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    libffi-dev \
    libssl-dev \
    tini

RUN bundle config --global frozen 1
COPY jruby.Gemfile /usr/src/app/Gemfile
COPY jruby.Gemfile.lock /usr/src/app/Gemfile.lock
RUN jruby -S bundle install --jobs=3 --retry=3

COPY . /usr/src/app

EXPOSE 3000

ENTRYPOINT ["tini", "--"]
#CMD ["bundle", "exec", "guard", "-i"]
CMD ["jruby", "-S", "bundle", "exec", "puma", "-C", "config/puma/puma.rb"]

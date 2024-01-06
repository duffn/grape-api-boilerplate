# grape-api-boilerplate

[![Tests](https://github.com/duffn/grape-api-boilerplate/actions/workflows/test.yml/badge.svg)](https://github.com/duffn/grape-api-boilerplate/actions/workflows/test.yml) [![Rubocop](https://github.com/duffn/grape-api-boilerplate/actions/workflows/rubocop.yml/badge.svg)](https://github.com/duffn/grape-api-boilerplate/actions/workflows/rubocop.yml) [![codecov](https://codecov.io/gh/duffn/grape-api-boilerplate/branch/main/graph/badge.svg?token=QWUQKQU3X1)](https://codecov.io/gh/duffn/grape-api-boilerplat)

A full-featured, production ready, and easy to understand API boilerplate for
the [Grape framework](https://github.com/ruby-grape/grape).

## Features

- Local development with [Docker](https://www.docker.com/) and Docker Compose.
- Automatic Puma reloading locally with [`guard-puma`](https://github.com/jc00ke/guard-puma).
- ActiveRecord with [`otr-activerecord`](https://github.com/jhollinger/otr-activerecord).
- Swagger API documentation with [`grape-swagger`](https://github.com/ruby-grape/grape-swagger).
- User authentication with [`bcrypt`](https://github.com/bcrypt-ruby/bcrypt-ruby)
  using [`jwt`](https://github.com/jwt/ruby-jwt).
- Model pagination with [`api-pagination`](https://github.com/davidcelis/api-pagination).
- Standard security headers with [`secure_headers`](https://github.com/github/secure_headers).
- Monitoring and alerting with [Sentry](https://sentry.io) and[Prometheus](https://prometheus.io).
- Comprehensive [RSpec](https://rspec.info/) test suite and code coverage.

## Running

- Generate a key pair for local JWT authentication.

```
cd grape-api-boilerplate/config/jwt
ssh-keygen -t rsa -b 4096 -m PEM -f jwtRS256.key
openssl rsa -in jwtRS256.key -pubout -outform PEM -out jwtRS256.key.pub
```

- Build and run with Docker Compose.

```
docker compose up --build
```

- Setup and seed the database.

```
docker compose exec app bundle exec rake db:setup
```

- Visit your API at http://localhost:3000

## Creating a user

- Run the create users Rake task.

```
docker compose run --rm app bundle exec rake users:create
```

- Enter your desired email, username, and password.

## Tests

- Run linting and tests.

```
docker compose run --rm -e RACK_ENV=test app bundle exec rake
```

## API documentation

When running locally, you can visit http://localhost:3000/public/swagger/index.html to view your Swagger API
documentation.

## Production

### Sentry

You can enable [Sentry](https://sentry.io/) for your API by setting `sentry.enabled` in your settings file(s).

- Update the setting in `app/settings/<environment>.yml`.

```yaml
sentry:
  enabled: true
```

- Add your Sentry DSN to a `SENTRY_DSN` environment variable.

- See the [Sentry Rack guide](https://docs.sentry.io/platforms/ruby/guides/rack/) for more.

### Prometheus

You can enable [Prometheus](https://prometheus.io/) metrics for your API by setting `prometheus.enabled` in your production settings file.

- Update the setting in `app/settings/production.yml`.

```yaml
prometheus:
  enabled: true
```

- The default middleware will provide some basic metrics out of the box. See the [Ruby Prometheus client library documentation](https://github.com/prometheus/client_ruby) for advanced usage.

_Note_: Prometheus metrics should not be exposed publicly! Please ensure you know what you're doing before enabling this feature in your environment.

### Docker

Build a production ready image with the [`Dockerfile`](Dockerfile) and deploy to your favorite platform.

```
docker build -t grape-api-boilerplate:latest .
```

## Contributing

Contributions are welcome! See [CONTRIBUTING](CONTRIBUTING.md).

## License

MIT License. See [LICENSE](LICENSE) for details.

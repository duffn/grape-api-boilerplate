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
- Comprehensive [RSpec](https://rspec.info/) test suite and code coverage.
- Easy [Heroku](https://www.heroku.com/) deployment.

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

### Heroku

You can easily deploy to Heroku with a few steps.

- Login and create a new Heroku application.

```
heroku login
heroku create
```

- Create a new hobby tier PostgreSQL database.

```
heroku addons:create heroku-postgresql:hobby-dev
```

- Generate a key pair for use with Heroku JWT authentication.
    - NOTE: _Ensure that you keep the private key secret and out of your git repository!_

```
ssh-keygen -t rsa -b 4096 -m PEM -f heroku_jwtRS256.key
openssl rsa -in heroku_jwtRS256.key -pubout -outform PEM -out heroku_jwtRS256.key.pub
```

- Set necessary [environment variables](https://devcenter.heroku.com/articles/config-vars).
    - One thing you'll want to look at specifically is how to set your Puma number of threads and PostgreSQL connection
      pool. Heroku as a [good article](https://devcenter.heroku.com/articles/concurrency-and-database-connections) on
      these topics.
    - You can set `DB_POOL` for the PostgreSQL connection pool, `MAX_THREADS` for the max number of Puma threads,
      and `WEB_CONCURRENCY` for the number of Puma workers.

```
RACK_ENV=production
GRAPE_BOILERPLATE_SETTINGS__JWT__PRIVATE_KEY=<contents of above heroku_jwtRS256.key>
GRAPE_BOILERPLATE_SETTINGS__JWT__PUBLIC_KEY=<contents of above heroku_jwtRS256.key.pub>
```

- Push your code to your new Heroku app.

```
git push heroku main
```

- Create an example user.

```
heroku run bundle exec rake users:create
```

- Use your new API!

#### Want to play around?

There's an instance of this API running at https://grape-api-boilerplate.herokuapp.com/. If it doesn't respond right
away, give it a few seconds to awake from the free tier hibernation.

```
# Hello world!
curl https://grape-api-boilerplate.herokuapp.com/api/v1/hello | jq .

# Authenticate with the test user.
token=$(curl -XPOST \
  -H "Content-Type:application/json" \
  -d '{"username":"grape_user","password":"grape_user1"}' \
  https://grape-api-boilerplate.herokuapp.com/api/login | jq -r '.token')

curl -H "Authorization: Bearer ${token}" \
  https://grape-api-boilerplate.herokuapp.com/api/v1/widget | jq . 
```

### Docker

Build a production ready image with the [`Dockerfile`](Dockerfile) and deploy to your favorite platform.

```
docker build -t grape-api-boilerplate:latest .
```

## Contributing

Contributions are welcome! See [CONTRIBUTING](CONTRIBUTING.md).

## License

MIT License. See [LICENSE](LICENSE) for details.
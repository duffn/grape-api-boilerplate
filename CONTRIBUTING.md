# Contributing

## Fork the Project

Fork the [project on GitHub](https://github.com/duffn/grape-api-boilerplate) and check out your copy.

```
git clone https://github.com/contributor/grape-api-boilerplate.git
cd grape-api-boilerplate
git remote add upstream https://github.com/duffn/grape-api-boilerplate.git
```

## Create a topic branch

Make sure your fork is up-to-date and create a topic branch for your feature or bug fix.

```
git checkout main
git pull upstream main
git checkout -b my-feature-branch
```

## Run the project locally

```
docker compose up --build
```

Run tests

```
docker compose run --rm -e RACK_ENV=test app bundle exec rake spec
```

## Write tests

Try to write a test that reproduces the problem you're trying to fix or describes a feature that you want to build and add them to the [spec](spec) directory.

I appreciate pull requests that highlight or reproduce a problem, even without a fix!

## Write Code

Implement your feature or bug fix.

Ruby style is enforced with [Rubocop](https://github.com/rubocop/rubocop). Run `docker compose run --rm -e RACK_ENV=test app bundle exec rake rubocop` and fix any style issues highlighted.

Make sure that `docker compose run --rm -e RACK_ENV=test app bundle exec rake spec` completes without errors.

## Commit Changes

Writing good commit messages is important. A commit message should describe what changed and why.

```
git add .
git commit -m "My awesome and useful commit message"
```

## Push

```
git push origin my-feature-branch
```

## Make a Pull Request

Go to https://github.com/contributor/grape-api-boilerplate.git and select your feature branch. Click the `Pull Request` button and fill out the form. Pull requests are usually reviewed within a few days.

## Rebase

If you've been working on a change for a while, rebase with `upstream/main`.

```
git fetch upstream
git rebase upstream/main
git push origin my-feature-branch -f
```

Amend your previous commit and force push the changes.

```
git commit --amend
git push origin my-feature-branch -f
```

## Check on Your Pull Request

Go back to your pull request after a minute or two and see whether it passed GitHub Actions CI. Everything should look green, otherwise fix issues and amend your commit as described above.

## Be Patient

It's likely that your change will not be merged and that the nitpicky maintainer will ask you to do more, or fix seemingly benign problems. Hang in there!

## Thank You

Please do know that I really appreciate and value your time and work.
#!/usr/bin/env rake
# frozen_string_literal: true

require 'bundler'

ENV['RAKE_ENV'] ||= 'development'

begin
  Bundler.setup :default, ENV.fetch('RACK_ENV', nil)
rescue Bundler::BundlerError => e
  warn e.message
  warn 'Run `bundle install` to install missing gems'
  exit e.status_code
end

require 'rake'

# Loads whole app for any other tasks
task :environment do
  require File.expand_path('config/environment.rb', __dir__)
end

# Don't bomb when running Rake tasks on Heroku.
begin
  # RSpec
  require 'rspec/core'
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec)

  # Rubocop
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new(:rubocop)

  # Bundler audit
  require 'bundler/audit/task'
  Bundler::Audit::Task.new
rescue LoadError
  puts 'Not loading development only rake tasks.'
end

# Shows app routes
task routes: :environment do
  GrapeApiBoilerplate::Api::Root.routes.each do |route|
    method = route.request_method.ljust(10)
    path = route.origin
    puts "      #{method} #{path}"
  end
end

# ActiveRecord tasks
require 'bundler/setup'
load 'tasks/otr-activerecord.rake'

namespace :db do
  task :environment do
    require_relative 'config/application'
  end
end

# Create a new user
def prompt(message)
  print(message)
  $stdin.gets.chop
end

namespace :users do
  task create: :environment do
    email = prompt('Email: ')
    username = prompt('Username: ')
    password = prompt('Password: ')

    user = User.new(username: username, password: password, email: email)
    user.save!
  end
end

task default: %i[rubocop spec]

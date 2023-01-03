# frozen_string_literal: true

workers Integer(ENV.fetch('WEB_CONCURRENCY', 1))
threads_count = Integer(ENV.fetch('MAX_THREADS', 5))
threads threads_count, threads_count

rackup DefaultRackup if defined?(DefaultRackup)
environment ENV.fetch('RACK_ENV', 'development')

preload_app!

bind "tcp://#{ENV.fetch('LISTEN', '0.0.0.0')}:#{ENV.fetch('PORT', 3000)}"

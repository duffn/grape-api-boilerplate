# frozen_string_literal: true

require File.expand_path('config/environment', __dir__)

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: :any
  end
end

use OTR::ActiveRecord::ConnectionManagement

use SecureHeaders::Middleware if ENV['RACK_ENV'] == 'production'

use Rack::Static, urls: ['/public/swagger'] unless ENV['RACK_ENV'] == 'production'

use Sentry::Rack::CaptureExceptions if Settings.sentry.enabled

if Settings.prometheus.enabled
  require 'prometheus/middleware/collector'
  require 'prometheus/middleware/exporter'

  use Rack::Deflater
  use Prometheus::Middleware::Collector
  use Prometheus::Middleware::Exporter
end

GrapeApiBoilerplate::Api::Root.compile!
run GrapeApiBoilerplate::Api::Root

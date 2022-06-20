# frozen_string_literal: true

require File.expand_path('config/environment', __dir__)

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: :any
  end
end

use OTR::ActiveRecord::ConnectionManagement

# Load Swagger UI when running locally.
use Rack::Static, urls: ['/public/swagger'] unless ENV['RACK_ENV'] == 'production'

API::Root.compile!
run API::Root

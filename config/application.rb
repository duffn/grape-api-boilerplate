# frozen_string_literal: true

$LOAD_PATH.unshift(File.dirname(__FILE__))

%w[api models services].each do |folder|
  $LOAD_PATH.unshift(File.expand_path("../app/#{folder}", __dir__))
end

require 'boot'

Bundler.require :default, ENV.fetch('RACK_ENV', nil)

Config.setup do |config|
  config.use_env = true
  config.env_prefix = 'GRAPE_BOILERPLATE_SETTINGS'
  config.env_separator = '__'
  config.env_converter = :downcase
  config.env_parse_values = true
end

Config.load_and_set_settings(
  Config.setting_files(File.dirname(__FILE__), ENV.fetch('RACK_ENV', nil))
)

OTR::ActiveRecord.configure_from_file! 'config/database.yml'
OTR::ActiveRecord.establish_connection!

Dir[File.expand_path('./initializers/*.rb', __dir__)].sort.each { |f| require f }

Dir[File.expand_path('../app/**/*.rb', __dir__)].sort.each do |file|
  require file
end

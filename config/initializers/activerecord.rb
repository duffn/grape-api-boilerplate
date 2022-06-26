ActiveRecord::Base.logger = Logger.new($stdout) if ENV['RACK_ENV'] == 'development'

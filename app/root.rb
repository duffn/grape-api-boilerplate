# frozen_string_literal: true

module GrapeApiBoilerplate
  module Api
    class Root < Grape::API
      format :json
      default_format :json
      content_type :json, 'application/json'
      prefix :api

      rescue_from :grape_exceptions

      # Logging
      insert_before Grape::Middleware::Error, GrapeLogging::Middleware::RequestLogger,
                    {
                      logger: logger,
                      formatter: GrapeLogging::Formatters::Json.new,
                      include: [GrapeLogging::Loggers::FilterParameters.new([:password])]
                    }

      # Helpers
      helpers do
        include Helpers
      end

      # Routes
      mount GrapeApiBoilerplate::Api::Endpoints::Session
      mount GrapeApiBoilerplate::Api::Endpoints::V1::HelloWorldEndpoint
      mount GrapeApiBoilerplate::Api::Endpoints::V1::WidgetEndpoint

      add_swagger_documentation \
        info: {
          title: 'Grape Boilerplate',
          description: 'A full-featured API boilerplate to get you started with the Grape framework.'
        }

      # Handle 404s
      route :any, '*path' do
        error!({ message: 'resource does not exist' }, 404)
      end
    end
  end
end

# frozen_string_literal: true

module GrapeApiBoilerplate
  module Api
    module Endpoints
      module V1
        class HelloWorldEndpoint < Grape::API
          version 'v1'

          resource :hello, desc: 'Hello worlds.' do
            desc 'Get a hello world.'
            get do
              { message: 'Hello World!' }
            end
          end
        end
      end
    end
  end
end

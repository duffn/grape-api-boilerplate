# frozen_string_literal: true

module GrapeApiBoilerplate
  module Api
    module Endpoints
      module V1
        class WidgetEndpoint < Grape::API
          version 'v1'

          include Grape::Jwt::Authentication
          auth :jwt

          resource :widget, desc: 'Widgets.' do
            paginate per_page: 10, max_per_page: 30
            desc 'Get all widgets.', {
              headers: {
                'Authorization' => {
                  description: 'Valid JWT bearer token in the format "Bearer token".',
                  required: true
                }
              }
            }
            get do
              payload = request_jwt.payload.to_h
              present paginate(Widget.where(user_id: payload[:user_id])), with: GrapeApiBoilerplate::Api::Entities::V1::WidgetEntity
            end
          end
        end
      end
    end
  end
end

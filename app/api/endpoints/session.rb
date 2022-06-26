# frozen_string_literal: true

module GrapeApiBoilerplate
  module Api
    module Endpoints
      class Session < Grape::API
        prefix :api
        format :json

        helpers do
          def authorized?
            declared_params = declared(params)
            user = User.find_by_username(declared_params[:username])
            return false if user.nil?
            return false unless user.authenticate(declared_params[:password])

            user.id
          end
        end

        desc 'Login a user and receive an authentication token.', {
          nickname: 'login',
          success: [{ code: 200 }],
          failure: [{ code: 401, message: 'Incorrect credentials were supplied.' }],
          produces: ['application/json'],
          consumes: ['application/json']
        }
        params do
          requires :username, type: String, documentation: { param_type: 'body' }
          requires :password, type: String, documentation: { param_type: 'body' }
        end
        post :login do
          if (user_id = authorized?)
            status :ok
            { token: JwtTokenService.new.encode(user_id:) }
          else
            status :unauthorized
            { message: 'incorrect credentials' }
          end
        end
      end
    end
  end
end

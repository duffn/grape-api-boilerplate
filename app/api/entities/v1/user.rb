# frozen_string_literal: true

module GrapeApiBoilerplate
  module Api
    module Entities
      module V1
        class UserEntity < Grape::Entity
          expose :id, documentation: { type: 'string' }
          expose :username, documentation: { type: 'string' }
        end
      end
    end
  end
end

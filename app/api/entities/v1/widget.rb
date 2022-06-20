# frozen_string_literal: true

module GrapeApiBoilerplate
  module Api
    module Entities
      module V1
        class WidgetEntity < Grape::Entity
          expose :id, documentation: { type: 'string' }
          expose :name, documentation: { type: 'string', desc: 'Widget name' }
        end
      end
    end
  end
end

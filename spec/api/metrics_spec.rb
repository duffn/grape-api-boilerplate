# frozen_string_literal: true

require 'spec_helper'

OUTER_APP = Rack::Builder.parse_file('config.ru').first

describe GrapeApiBoilerplate::Api::Root do
  include Rack::Test::Methods

  def app
    OUTER_APP
  end

  it 'cannot get metrics when setting is not enabled' do
    get '/metrics'
    expect(last_response.status).to eq(404)
  end
end

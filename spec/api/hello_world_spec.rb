# frozen_string_literal: true

require 'spec_helper'

describe API::Root do
  include Rack::Test::Methods

  def app
    API::Root
  end

  it 'gets hello world' do
    get '/api/v1/hello'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to eq({ message: 'Hello World!' }.to_json)
  end
end

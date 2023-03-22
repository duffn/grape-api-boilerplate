# frozen_string_literal: true

require 'spec_helper'

describe GrapeApiBoilerplate::Api::Endpoints::Session do
  include Rack::Test::Methods

  def app
    GrapeApiBoilerplate::Api::Root
  end

  let(:user) do
    create(:user)
  end

  it 'logs in successfully with correct credentials' do
    post '/api/login', username: user.username, password: 'password1'
    expect(last_response.status).to eq(200)
    expect(JSON.parse(last_response.body, symbolize_names: true).keys).to contain_exactly(:token)
  end

  it 'cannot login with incorrect password' do
    post '/api/login', username: user.username, password: 'wrong_password'
    expect(last_response.status).to eq(401)
    expect(last_response.body).to eq({ message: 'incorrect credentials' }.to_json)
  end

  it 'cannot login with incorrect username' do
    post '/api/login', username: 'does_not_exist', password: 'password1'
    expect(last_response.status).to eq(401)
    expect(last_response.body).to eq({ message: 'incorrect credentials' }.to_json)
  end
end

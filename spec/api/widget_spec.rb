# frozen_string_literal: true

require 'spec_helper'

describe API::Root do
  include Rack::Test::Methods

  def app
    API::Root
  end

  before do
    user = create(:user)
    post '/api/login', username: user.username, password: 'password1'
    response = JSON.parse(last_response.body, symbolize_names: true)
    @token = response[:token]

    31.times do |_|
      create(:widget, user_id: user.id)
    end
  end

  it 'gets widgets' do
    header 'Authorization', "Bearer #{@token}"
    get '/api/v1/widget'
    expect(last_response.status).to eq(200)
    expect(JSON.parse(last_response.body).length).to eq(10)
  end

  it 'gets a second page of widgets' do
    header 'Authorization', "Bearer #{@token}"
    get '/api/v1/widget?page=2'
    expect(last_response.status).to eq(200)
    expect(JSON.parse(last_response.body, symbolize_names: true).length).to eq(10)
    expect(last_response.headers['Link']).to eq('<http://example.org/api/v1/widget?page=1>; rel="first", <http://example.org/api/v1/widget?page=1>; rel="prev", <http://example.org/api/v1/widget?page=3>; rel="next"')
  end

  it 'gets max number of widgets' do
    header 'Authorization', "Bearer #{@token}"
    get '/api/v1/widget?per_page=35'
    expect(last_response.status).to eq(200)
    expect(JSON.parse(last_response.body).length).to eq(30)
    expect(last_response.headers['Per-Page']).to eq('30')
  end

  it 'gets an empty array when a user has no widgets' do
    user = create(:user)
    post '/api/login', username: user.username, password: 'password1'
    response = JSON.parse(last_response.body, symbolize_names: true)

    header 'Authorization', "Bearer #{response[:token]}"
    get '/api/v1/widget'
    expect(last_response.status).to eq(200)
    expect(JSON.parse(last_response.body).length).to eq(0)
  end

  it 'is unauthorized without a token' do
    get '/api/v1/widget'
    expect(last_response.status).to eq(401)
    expect(last_response.body).to eq({ message: 'authentication token missing or malformed' }.to_json)
  end

  it 'is unauthorized with an incorrect token' do
    header 'Authorization', 'Bearer wrong_token'
    get '/api/v1/widget'
    expect(last_response.status).to eq(401)
    expect(last_response.body).to eq({ message: 'authentication token missing or malformed' }.to_json)
  end
end

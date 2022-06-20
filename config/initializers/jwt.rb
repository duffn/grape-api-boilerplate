# frozen_string_literal: true

Grape::Jwt::Authentication.configure do |config|
  if Settings.jwt.public_key
    File.write('./public.key.pub', Settings.jwt.public_key) unless File.file?('./public.key.pub')
    config.rsa_public_key_url = './public.key.pub'
  else
    config.rsa_public_key_url = Settings.jwt.public_key_url
  end

  config.jwt_issuer = Settings.jwt.issuer

  config.malformed_auth_handler = proc do
    response_body = {
      message: 'authentication token missing or malformed'
    }.to_json
    [401, { 'Content-Type' => 'application/json' }, [response_body]]
  end

  config.failed_auth_handler = proc do
    response_body = {
      message: 'unauthorized access'
    }.to_json
    [403, { 'Content-Type' => 'application/json' }, [response_body]]
  end

  config.authenticator = proc do |token|
    jwt = Keyless::Jwt.new(token)
    jwt.valid?
  end
end

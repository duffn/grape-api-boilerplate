# frozen_string_literal: true

class JwtTokenService
  ALGORITHM = 'RS256'
  CLAIMS = {
    iss: Settings.jwt.issuer
  }.freeze
  LEEWAY = 30

  def encode(payload)
    JWT.encode(prepare_payload(payload, expiry_time), private_key, ALGORITHM, typ: 'JWT')
  end

  def decode(token)
    JWT.decode(token, public_key, true, {
                 iss: Settings.jwt.issuer, verify_iss: true, exp_leeway: LEEWAY, algorithm: ALGORITHM
               })
  end

  private

  def private_key
    return key_from_env(:private) if Settings.jwt.private_key

    path = Settings.jwt.private_key_path
    OpenSSL::PKey::RSA.new(File.read(path))
  end

  def public_key
    return key_from_env(:public) if Settings.jwt.public_key

    path = Settings.jwt.public_key_url
    OpenSSL::PKey::RSA.new(File.read(path))
  end

  def prepare_payload(payload, time)
    payload[:exp] = time
    payload.merge(CLAIMS)
  end

  def expiry_time
    minutes = Settings.jwt.expiration_time_minutes.to_i
    Time.now.to_i + (minutes * 60)
  end

  def key_from_env(setting)
    OpenSSL::PKey::RSA.new({ private: Settings.jwt.private_key, public: Settings.jwt.public_key }[setting])
  end
end

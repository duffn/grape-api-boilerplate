# frozen_string_literal: true

SecureHeaders::Configuration.default do |config|
  # Configure headers per https://infosec.mozilla.org/guidelines/web_security#examples-4
  # These are likely not needed in an API.
  config.x_content_type_options = SecureHeaders::OPT_OUT
  config.x_xss_protection = SecureHeaders::OPT_OUT
  config.x_permitted_cross_domain_policies = SecureHeaders::OPT_OUT
  config.x_download_options = SecureHeaders::OPT_OUT

  # Set these headers.
  config.x_frame_options = 'DENY'
  config.csp = {
    preserve_schemes: true,
    disable_nonce_backwards_compatibility: true,
    # rubocop:disable Lint/PercentStringArray
    default_src: %w['none'],
    script_src: %w['none'],
    frame_ancestors: %w['none']
    # rubocop:enable Lint/PercentStringArray
  }

  # While this header should definitely be enabled, the boilerplate leaves it
  # up to you to test in your environment and enable after you're certain it's
  # safe to do for your use case.
  # config.hsts = "max-age=#{1.year.to_i}" if ENV['RACK_ENV'] == 'production'
end

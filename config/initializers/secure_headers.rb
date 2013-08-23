::SecureHeaders::Configuration.configure do |config|
  config.hsts = {:max_age => 13.years.to_i, :include_subdomains => true}
  config.x_frame_options = 'SAMEORIGIN'
  config.x_content_type_options = "nosniff"
  config.x_xss_protection = {:value => 1, :mode => 'block'}
end
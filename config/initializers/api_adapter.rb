ActiveRestClient::Base.faraday_config do |faraday|
  faraday.headers['X-API-Key'] = Rails.application.config.propublica[:api_key]
end

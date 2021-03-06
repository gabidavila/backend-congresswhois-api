require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
# require 'sprockets/railtie'
require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BackendPropublicaApi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: [:get, :post, :options]
      end
    end

    config.api_only   = true
    config.propublica = {
      api_base_url: ENV.fetch('PROPUBLICA_MAIN_ENDPOINT'),
      api_key:      ENV.fetch('PROPUBLICA_API'),
      congress:     {
        current_house:  ENV.fetch('PROPUBLICA_CURRENT_HOUSE'),
        current_senate: ENV.fetch('PROPUBLICA_CURRENT_SENATE')
      },
      twitter:      {
        consumer_key:        ENV.fetch('TWITTER_CONSUMER_KEY'),
        consumer_secret:     ENV.fetch('TWITTER_CONSUMER_SECRET'),
        access_token:        ENV.fetch('TWITTER_ACCESS_TOKEN'),
        access_token_secret: ENV.fetch('TWITTER_ACCESS_TOKEN_SECRET')
      }
    }
  end
end

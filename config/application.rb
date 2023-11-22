require_relative "boot"

require "rails/all"
require 'apartment/elevators/subdomain'
require_relative '../lib/apartment/custom_elevator'
require_relative '../app/services/kafka_service'



# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TestDb
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    # config.middleware.use Apartment::Elevators::Subdomain
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    
    # config.hosts = ['eu.lvh.me','localhost','vn.lvh.me','lvh.me']
    config.hosts = ['localhost','lvh.me']
    config.autoload_paths << Rails.root.join('lib')
    
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.api_only = true
  end
end

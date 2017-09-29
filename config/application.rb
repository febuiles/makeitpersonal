require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Makeitpersonal
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
  end
end

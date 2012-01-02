require File.expand_path('../boot', __FILE__)

require "action_controller/railtie"
require "action_mailer/railtie"
require "active_resource/railtie"
require "rails/test_unit/railtie"
require "sprockets/railtie"

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module LastPlaylist
  class Application < Rails::Application
    config.time_zone = 'Eastern Time (US & Canada)'
    config.encoding = "utf-8"
    config.assets.enabled = true
    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += %W(#{config.root}/lib/last_fm)
    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'
  end
end

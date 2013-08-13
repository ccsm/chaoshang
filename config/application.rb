require File.expand_path('../boot', __FILE__)

require "action_controller/railtie"
require "action_mailer/railtie"
require "rails/test_unit/railtie"
require 'sprockets/railtie'


if defined?(Bundler)
  Bundler.require *Rails.groups(:assets => %w(production development test))
end

module Chaoshang
  class Application < Rails::Application

    # Mongoid configuration
    config.mongoid.raise_not_found_error = false
    config.mongoid.identity_map_enabled = true      
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.time_zone = 'Beijing'



    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.yml')] 
    config.i18n.default_locale = :zh

  end
end

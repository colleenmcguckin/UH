require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'devise'
require 'devise/orm/active_record'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module UH
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Pacific Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # Try loading a YAML file at `./config/env.[environment].yml`, if it exists
    def load_env_file(environment = nil)
      path = Rails.root.join("config", "env#{environment.nil? ? '' : '.'+environment}.yml")
      return unless File.exist? path
      config = YAML.load(ERB.new(File.new(path).read).result)
      config.each { |key, value| ENV[key.to_s] = value.to_s }
    end

    # Load environment variables. config/env.yml contains defaults which are
    # suitable for development. (This file is optional).
    load_env_file

    # Now look for custom environment variables, stored in env.[environment].yml
    # For development, this file is not checked into source control, so feel
    # free to tweak for your local development setup. Any values defined here
    # overwrite the defaults in `env.yml`
    load_env_file(Rails.env)
  end
end

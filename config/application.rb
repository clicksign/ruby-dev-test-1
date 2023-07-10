require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RubyDevTest1
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.time_zone = 'Brasilia'

    config.i18n.available_locales = %i[en pt-BR]
    config.i18n.default_locale    = :'pt-BR'

    config.api_only = true
  end
end

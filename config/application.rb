require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RubyDevTest1
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.active_record.default_timezone = :local
    config.encoding = 'UTF-8'
    config.i18n.available_locales = [:en, 'pt-BR']
    config.i18n.default_locale = 'pt-BR'
    config.time_zone = 'Brasilia'

    # carrega os locales separados em vários arquivos

    config.i18n.load_path += Dir[
      Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s
    ]
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end

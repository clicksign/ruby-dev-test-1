require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"

Bundler.require(*Rails.groups)

module FileStorage
  class Application < Rails::Application
    config.load_defaults 7.0
    config.time_zone = "Brasilia"
    I18n.default_locale = :"pt-BR"
    config.active_record.schema_format = :sql
    config.api_only = true
    config.generators do |g|
      g.test_framework :rspec
    end
  end
end

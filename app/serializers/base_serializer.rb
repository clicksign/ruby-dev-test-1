# frozen_string_literal: true

class BaseSerializer < Blueprinter::Base
  class << self
    include Rails.application.routes.url_helpers
  end
end

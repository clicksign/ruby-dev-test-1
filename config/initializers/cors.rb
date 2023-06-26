# frozen_string_literal: true

CORS_ORIGINS = ENV.fetch("CORS_ORIGINS") { "*" }

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins CORS_ORIGINS.split(";")
    resource "*",
             headers: :any,
             methods: %i[get post put patch delete options head],
             # XXX: Expondo os headers de paginação explicitamente
             # https://stackoverflow.com/questions/37897523/axios-get-access-to-response-header-fields#comment79785501_37931084
             expose:  %w[Link X-Total X-Page X-Per-Page]
  end
end

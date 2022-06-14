require 'rspec_api_documentation/dsl'
require 'rails_helper'
require 'rspec_api_documentation'

RspecApiDocumentation.configure do |config|

  # Set the application that Rack::Test uses
  config.app = Rails.application

  # An array of output format(s).
  # Possible values are :json, :html, :combined_text, :combined_json,
  #   :json_iodocs, :textile, :markdown, :append_json, :slate,
  #   :api_blueprint, :open_api
  config.format = [:json]

  # By default, when these settings are nil, all headers are shown,
  # which is sometimes too chatty. Setting the parameters to an
  # array of headers will render *only* those headers.
  config.request_headers_to_include = ["Host", "Content-Type"]
  config.response_headers_to_include = ["Host", "Content-Type"]

  # By default examples and resources are ordered by description. Set to true keep
  # the source order.
  config.keep_source_order = true

end
# frozen_string_literal: true

module Support
  module ControllerHelper
    # Returns the object of a json rendered http response
    def parsed_response
      JSON.parse(response.body, symbolize_keys: true)
    end
  end
end

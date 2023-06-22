# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  set_current_tenant_through_filter
  before_action :authenticate

  private

  def authenticate
    if (user = authenticate_with_http_basic { |u, p| User.find_by(name: u)&.authenticate(p) })
      set_current_tenant(user)
    else
      request_http_basic_authentication
    end
  end
end

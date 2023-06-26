module AuthenticationGuard
  extend ActiveSupport::Concern

  class Error < ::StandardError
    attr_reader :status, :code

    def initialize(*args, status: nil, code: nil)
      super(*args)

      @status = status unless status.nil?
      @code   = code unless code.nil?
    end

    def default_status
      500
    end

    def default_code
      "unauthorized"
    end

    def status
      @status || default_status
    end

    def code
      @code || default_code
    end
  end

  class UnauthorizedError < Error
    def default_status
      401
    end

    def default_code
      "unauthorized"
    end
  end

  included do
    # Enable acts_as_tenant
    set_current_tenant_through_filter

    # Basic Auth
    include ActionController::HttpAuthentication::Basic::ControllerMethods
    before_action :authenticate_user!

    # Custom Errors
    include ::AuthenticationGuard::ControllerMethods
    rescue_from ::AuthenticationGuard::Error do |e|
      render status: e.status, json: { error: e.code, message: e&.message }
    end
  end

  module ControllerMethods
    private

    attr_reader :current_user

    # filters
    # ---

    def authenticate_user!
      @current_user = authenticate_with_http_basic { |u, p| User.find_by(email: u)&.authenticate(p) }

      return raise ::AuthenticationGuard::UnauthorizedError.new unless @current_user

      set_current_tenant(@current_user)

      @current_user
    end
  end
end

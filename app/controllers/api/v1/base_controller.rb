module Api::V1
  class BaseController < ActionController::API
    include AuthenticationGuard
    include ApplicationControlling
  end
end

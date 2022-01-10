class ApplicationController < ActionController::API

  include SimpleErrorRenderable
  self.simple_error_partial = "shared/simple_error"
end

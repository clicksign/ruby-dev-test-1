# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Api::ExceptionHandler
  include Api::ResponseConcerns

  def page
    params[:page] || 1
  end
end

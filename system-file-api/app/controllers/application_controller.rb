# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from 'ActiveRecord::RecordNotFound' do |exception|
    render json: { error: exception.class.to_s, message: "#{exception.model} with id #{exception.id} not found" }, status: :not_found
  end
end

# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from 'ActiveRecord::RecordNotFound' do |exception|
    render json: { error: exception.class.to_s, message: "#{exception.model} with id #{exception.id} not found" }, status: :not_found
  end

  rescue_from 'ActiveRecord::RecordInvalid' do |exception|
    Rails.logger.debug 'uire'
    render json: { error: exception.class.to_s, message: exception.message }, status: :unprocessable_entity
  end
end

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::ParameterMissing, with: :missing_param

  private

  def record_not_found(e)
    render json: { error: 'resource not found' }, status: :not_found
  end

  def missing_param(e)
    render json: { error: e.to_s }, status: :bad_request
  end
end

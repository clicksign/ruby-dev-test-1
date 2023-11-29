# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :invalid
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from SQLite3::ConstraintException, with: :constraint_exception

  private

  def constraint_exception(exception)
    render json: { error: exception.to_s }, status: :unprocessable_entity
  end

  def invalid(exception)
    render json: { error: exception.to_s }, status: :unprocessable_entity
  end

  def not_found(exception)
    render json: { error: exception.to_s }, status: :not_found
  end

  def paginate_params
    params.permit(:page, :per_page)
  end
end

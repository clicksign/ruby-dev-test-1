class ContractsController < ApplicationController
  def index
    @contracts = Contracts::FetchPage.list(
      page: params[:page],
      user_id: params[:user_id]
    )
  end

  def show
    @contract = Contracts::Finder.find(
      user_id: params[:user_id],
      id: params[:id]
    )
  end

  def create
    @contract = ::Contracts::CreatorProcessor.call(
      contract_params.to_h.merge({user_id: params[:user_id]})
    )
    render :show, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.message }, status: 500
  end

  private

  def contract_params
    params.require(:contract).permit(
      :file, :description
    )
  end
end

class AssetsController < ApplicationController
  before_action :set_asset, only: %i[ show update destroy ]

  # # GET /assets/1
  def show
    render json: AssetSerializer.new(@asset).serializable_hash
  end

  # POST /assets
  def create
    @asset = AssetCreator.new(asset_params).create_asset

    if @asset.errors.any?
      render json: @asset.errors, status: :unprocessable_entity
    else
      render json: @asset, status: :created, location: @asset
    end
  end

  # # DELETE /assets/1
  def destroy
    @asset.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asset
      @asset = Asset.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def asset_params
      params.permit(:name, :node_id, :file)
    end
end
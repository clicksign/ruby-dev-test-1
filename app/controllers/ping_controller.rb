class PingController < ApplicationController
  # GET /ping
  def show
    render json: { pong: DateTime.current.utc }
  end
end

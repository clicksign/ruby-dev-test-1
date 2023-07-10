module Api
  module V1
    class StatusController < ApplicationController
      def index
        render json: { message: 'OK' }, status: :ok
      end
    end
  end
end

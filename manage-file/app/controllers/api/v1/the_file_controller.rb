module Api
	module V1
		class TheFileController < ApplicationController			
			def search
				files = TheFile.where(name: params[:name])
				render json: {data: files}, status: :ok
			end
		end
	end
end
module Api
	module V1
		class DirectoryController < ApplicationController
			def list
				dirs = Directory.all
				render json: {data: dirs}, status: :ok
			end         

			def create
				dir = Directory.create(
					:name => params[:name],
					:parent_id => params[:parent_id] ? params[:parent_id] : nil
				)
				if dir.save
					render json: {message: "saved"}, status: :ok
				else
					render json: {message: "error on create"}, status: :error
				end
			end

			def destroy
				dir = Directory.find(name: params[:name])
				if dir
					dir.destroy
					render json: {message: "saved"}, status: :ok
				else
					render json: {message: "error on destroy"}, status: :error
				end
			end

			def search
				dirs = Directory.where(name: params[:name])
				render json: {result: dirs}, status: :ok
			end

			def directory_params
				params.permit(:name, :parent_id)
			end
		end
	end
end
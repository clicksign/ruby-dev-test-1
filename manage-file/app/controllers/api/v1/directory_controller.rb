module Api
	module V1
		class DirectoryController < ApplicationController
						
			def tree 

				data = []
				r = Directory.find_by(name: params[:name])
				if r
					data = r.tree
				end
				
				render json: {data: data}, status: :ok
			end

			def search
				dirs = Directory.where(name: params[:name])
				render json: {bla: params, result: dirs}, status: :ok
			end

			def directory_params
				params.permit(:name, :parent_id)
			end			
		end
	end
end
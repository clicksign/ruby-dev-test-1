module Api
	module V1
		class ManageController < ApplicationController
			def upload_file
				if params[:file]
					paths = params[:path].split('/')
					has_root = Directory.where(:parent_id => nil).find_by(:name => paths[0])
					last_dir = nil
					paths.each_with_index { |p, i|
						if i > 0 && has_root
							has_root = has_root.subdir.find_by(:name => p)
						end

						if !has_root
							dir = Directory.create(
								:name => p,
								:parent_id => last_dir ? last_dir.id : nil
							)
							last_dir = dir
						else
							last_dir = has_root
						end
					}
					
					filename = params[:file].original_filename
					if !last_dir.the_files.find_by(:name => filename)
						file = TheFile.create(
							:name => filename,
							:blob =>  params[:file].tempfile.read,
							:directory_id => last_dir.id
						)
						if file.save
							render json: {message: "saved"}, status: :ok
						else
							render json: {message: "error on create", errors: last_dir.errors}, status: :bad_request
						end
					else
						render json: {message: "file exist"}, status: :bad_request
					end
				else
					render json: {ret: params[:file].tempfile.read}, status: :ok
				end
			end
		end
	end
end
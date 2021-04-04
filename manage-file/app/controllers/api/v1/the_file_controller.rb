module Api
	module V1
		class TheFileController < ApplicationController
			def create
				
				paths = params[:path].split('/')
				has_root = Directory.where(:parent_id => nil).find_by(:name => paths[0])
				obj = nil
				paths.each_with_index { |p, i|
					if i > 0 && has_root						
						has_root = has_root.subdir.find_by(:name => p)						
					end

					if !has_root
						dir = Directory.create(
							:name => p,
							:parent_id => obj ? obj.id : nil
						)
						obj = dir						
					else
						obj = has_root
					end
				}

=begin 			
				if params[:file]
					dir = Directory.create(
						:name => 'abcde'
					)
					file = TheFile.create(
						:name => params[:file].original_filename,
						:blob =>  params[:file].tempfile.read,
						:directory_id => dir.id
					)
					if file.save
						render json: {message: "saved"}, status: :ok
					else
						render json: {message: "error on create", errors: dir.errors}, status: :bad_request
					end
				else
					render json: {ret: params[:file].tempfile.read}, status: :ok
				end
=end

				render json: {ret: obj}, status: :ok

			end

			def search
				files = TheFile.where(name: params[:name])
				render json: {data: files}, status: :ok
			end

			private
			def recursive name, directory
				#dir = directory.subdir.where(:name => name)
				#if dircount
			end
		end
	end
end
class AwsFilesController < ApplicationController
  require 'aws-sdk-s3'

  def create
    @aws_file = AwsFile.new(aws_file_params)

    if @aws_file.save
      upload_file_to_s3(aws_file_params[:url], aws_file_params['path'])
      redirect_to root_path, notice: 'Arquivo carregado com sucesso.'
    else
      render :new
    end
  end

  def destroy
    @file = File.find(params[:id])

    s3_client = Aws::S3::Resource.new(region: 'your_aws_region')
    bucket = s3_client.bucket('your_bucket_name')
    object = bucket.object(@file.path_in_s3)

    object.delete

    @file.destroy

    redirect_to directories_path, notice: 'File deleted successfully.'
  end

  private

  def aws_file_params
    params.require(:aws_file).permit(:name, :directory_id, :url, :path)
  end

  def upload_file_to_s3(file, directory_path)
    s3 = Aws::S3::Resource.new(region: ENV['AWS_REGION'])
    bucket = s3.bucket(ENV['S3_BUCKET_NAME'])
    object = bucket.object("#{directory_path}/#{file.original_filename}")

    object.put(body: file.read)
  end
end

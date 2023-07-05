class DirectoriesController < ApplicationController
  def index
    @directories = Directory.all
  end

  def new
    @directory = Directory.new
  end

  def create
    @directory = Directory.new(directory_params)

    if @directory.save
      redirect_to directories_path, notice: 'Directory Created'
    else
      render :new
    end
  end

  def show
    @directory = Directory.find(params[:id])
    @aws_file = AwsFile.new(directory: @directory)
  end

  def destroy
    @directory = Directory.find(params[:id])
    @directory.destroy
    redirect_to directories_path, notice: 'Directory Deleted'
  end

  private

  def directory_params
    params.require(:directory).permit(:name, :parent_id)
  end
end

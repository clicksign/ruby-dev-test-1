class AppFilesController < ApplicationController
  def create
    app_file      = AppFile.new(app_folder_id: app_file_params['app_folder_id'])
    redirect_path = app_file.app_folder.present? ? root_path(id: app_file.app_folder.id) : root_path

    if app_file_params['file_content'].present?
      app_file.file_content.attach(io: app_file_params['file_content'], filename: app_file_params['file_content'].original_filename)
    end
      
    if app_file.save
        redirect_to redirect_path
    else
      redirect_to redirect_path, alert: app_file.errors.full_messages.join(', ')
    end
  end

  def destroy
    app_file      = AppFile.find(params[:id])
    redirect_path = app_file.app_folder.present? ? root_path(id: app_file.app_folder.id) : root_path
      
    if app_file.destroy
      redirect_to redirect_path
    else
      redirect_to redirect_path, alert: app_file.errors.full_messages.join(', ')
    end
  end

  private

  def app_file_params
    params.require(:app_file).permit(:file_content, :app_folder_id)
  end
end

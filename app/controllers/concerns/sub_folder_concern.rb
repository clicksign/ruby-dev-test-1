module SubFolderConcern 
  extend ActiveSupport::Concern
  def create_sub_folder_into_a_folder(sub_folder_params)
  	
  	@folder = Folder.find(sub_folder_params[:folder_id_form_url]) 
    @last_subfolder = SubFolder.last
    @folder.sub_folders << @last_subfolder

    return @folder
  end

  def there_is_a_folder?(sub_folder_params)
  	sub_folder_params[:folder_id_form_url].to_i > 0
  end
end
class FolderIdValidator < ActiveModel::Validator
  def validate(folder)
    folder.errors.add(:folder_id, :cant_be_parent) if invalid_folder_id?(folder)
  end

  def invalid_folder_id?(folder)
    Folder.where('path_ids @> ARRAY[?]', folder.id.to_i).exists?(id: folder.folder_id)
  end
end

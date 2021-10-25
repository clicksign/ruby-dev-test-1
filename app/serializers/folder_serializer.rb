class FolderSerializer < ActiveModel::Serializer
  attributes :id, :name, :parent_folder_id, :is_root_folder?
end

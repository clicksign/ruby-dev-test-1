ActiveAdmin.register Documents::LocalDocument do
  permit_params :name, :directory_id, :file

  form do |f|
    inputs 'Details' do
      input :name
      input :directory
      input :file, as: :file
      actions
    end
  end

  show do
    attributes_table do
      row :name
      row :directory
      row :file
      render 'file_download', { file: documents_local_document.file }
    end
  end
end

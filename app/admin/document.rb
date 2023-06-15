ActiveAdmin.register Documents::LocalDocument do
  permit_params :name, :directory_id
end

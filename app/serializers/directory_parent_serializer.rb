class DirectoryParentSerializer < ApplicationSerializer
  attributes :id,
             :name,
             :path

  def path
    object&.path
  end
end

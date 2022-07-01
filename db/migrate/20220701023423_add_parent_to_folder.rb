class AddParentToFolder < ActiveRecord::Migration[7.0]
  def change
    add_reference :folders, :parent, index: true
  end
end

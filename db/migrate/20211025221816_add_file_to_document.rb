class AddFileToDocument < ActiveRecord::Migration[6.1]
  def change
    add_column :documents, :file, :string
  end
end

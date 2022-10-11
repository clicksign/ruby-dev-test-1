class CreateDirectory < ActiveRecord::Migration[7.0]
  def change
    create_table :directories do |t|
      t.string :name
      t.integer :parent_directory_id, index: true
      t.timestamps
    end
  end
end

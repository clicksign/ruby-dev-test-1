class CreateBinds < ActiveRecord::Migration[7.0]
  def change
    create_table :binds do |t|
      t.integer :child_id
      t.integer :parent_id

      t.timestamps
    end
    add_index :binds, :child_id
    add_index :binds, :parent_id
    add_index :binds, [:child_id, :parent_id], unique: true
  end
end

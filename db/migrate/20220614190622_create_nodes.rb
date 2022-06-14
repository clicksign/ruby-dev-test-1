class CreateNodes < ActiveRecord::Migration[6.1]
  def change
    create_table :nodes do |t|
      t.integer :node_type
      t.string :name

      t.timestamps
    end
  end
end

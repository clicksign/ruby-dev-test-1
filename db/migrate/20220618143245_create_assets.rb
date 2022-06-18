class CreateAssets < ActiveRecord::Migration[7.0]
  def change
    create_table :assets do |t|
      t.string :name
      t.integer :node_id

      t.timestamps
    end
  end
end

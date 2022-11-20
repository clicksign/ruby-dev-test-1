class CreateStorables < ActiveRecord::Migration[7.0]
  def change
    create_table :storables do |t|
      t.string :name
      t.string :type, index: true
      t.references :parent, index: true

      t.timestamps
    end
  end
end

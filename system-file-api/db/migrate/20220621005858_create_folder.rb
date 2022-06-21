class CreateFolder < ActiveRecord::Migration[6.1]
  def change
    create_table :folders do |t|
      t.string :name
      t.references :parent, index: true, null: true
      t.timestamps
    end
  end
end

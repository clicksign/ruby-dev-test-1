class CreateDirectories < ActiveRecord::Migration[7.0]
  def change
    create_table :directories do |t|
      t.string :name
      t.references :parent, foreign_key: { to_table: :directories }
      
      t.timestamps
    end
  end
end
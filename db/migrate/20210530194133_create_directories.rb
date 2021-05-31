class CreateDirectories < ActiveRecord::Migration[6.1]
  def change
    create_table :directories do |t|
      t.string :name
      t.string :ancestry
      t.timestamps
      t.index :ancestry
      t.index %i[ancestry name], unique: true
    end
  end
end

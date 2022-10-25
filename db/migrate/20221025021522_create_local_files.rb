class CreateLocalFiles < ActiveRecord::Migration[7.0]
  def change
    create_table :local_files do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end

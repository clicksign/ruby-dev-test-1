class CreateSubDirectories < ActiveRecord::Migration[6.1]
  def change
    create_table :sub_directories do |t|
      t.string :name
      t.string :path

      t.timestamps
    end
  end
end

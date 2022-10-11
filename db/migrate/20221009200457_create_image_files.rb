class CreateImageFiles < ActiveRecord::Migration[7.0]
  def change
    create_table :image_files do |t|
      t.string :name
      t.references :directory, index: true
      t.timestamps
    end
  end
end

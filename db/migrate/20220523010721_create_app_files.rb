class CreateAppFiles < ActiveRecord::Migration[7.0]
  def change
    create_table :app_files do |t|
      t.references :app_folder, null: true, foreign_key: true

      t.timestamps
    end
  end
end

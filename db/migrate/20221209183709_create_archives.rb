class CreateArchives < ActiveRecord::Migration[7.0]
  def change
    create_table :archives, id: :uuid do |t|
      t.references :directory, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end

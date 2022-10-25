class CreateMedia < ActiveRecord::Migration[7.0]
  def change
    create_table :media do |t|
      t.belongs_to :folder,   null: false, foreign_key: true
      t.references :fileable, polymorphic: true, null: false

      t.timestamps
    end
  end
end

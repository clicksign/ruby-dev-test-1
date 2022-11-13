class CreateUploads < ActiveRecord::Migration[7.0]
  def change
    create_table :uploads do |t|
      t.string  :title, null: false
      t.json  :info, null: false

      t.timestamps
    end
  end
end

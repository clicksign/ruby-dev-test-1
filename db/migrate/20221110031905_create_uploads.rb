class CreateUploads < ActiveRecord::Migration[6.1]
  def change
    create_table :uploads do |t|
      t.string  :title, null: false
      t.json  :info, null: false

      t.timestamps
    end
  end
end

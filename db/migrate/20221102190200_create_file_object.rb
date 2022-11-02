# frozen_string_literal: true

class CreateFileObject < ActiveRecord::Migration[7.0]
  def change
    create_table :file_objects do |t|
      t.string :name, null: false
      t.string :path, null: false
      t.references :directory, foreign_key: true
      t.timestamps
    end
  end
end

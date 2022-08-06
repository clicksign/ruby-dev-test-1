# frozen_string_literal: true

class CreateDirectories < ActiveRecord::Migration[7.0]
  def change
    create_table :directories do |t|
      t.string :name, null: false, limit: 100
      t.string :slug, null: false
      t.string :ancestry, index: true

      t.index %i[name ancestry], unique: true

      t.timestamps
    end
  end
end

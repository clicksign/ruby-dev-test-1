# frozen_string_literal: true

class CreateDirectories < ActiveRecord::Migration[7.0]
  def change
    create_table :directories do |t|
      t.string :name, null: false
      t.references :parent, foreign_key: { to_table: :directories }
      t.index %i[name parent_id], unique: true

      t.timestamps
    end
  end
end

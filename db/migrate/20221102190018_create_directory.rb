# frozen_string_literal: true

class CreateDirectory < ActiveRecord::Migration[7.0]
  def change
    create_table :directories do |t|
      t.string :name, null: false
      t.references :parent_directory, index: true, null: true
      t.timestamps
    end
  end
end

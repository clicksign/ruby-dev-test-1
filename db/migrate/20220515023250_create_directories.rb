# frozen_string_literal: true

class CreateDirectories < ActiveRecord::Migration[7.0]
  def change
    create_table :directories do |t|
      t.string :title
      t.references :parent, index: true
      t.timestamps
    end
  end
end

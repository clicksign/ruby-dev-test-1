# frozen_string_literal: true

class CreateStorables < ActiveRecord::Migration[7.0]
  def change
    enable_extension :citext

    create_table :storables do |t|
      t.citext :name
      t.string :type, index: true
      t.references :parent, index: true

      t.timestamps
    end

    add_index :storables, :name, unique: true, where: 'parent_id IS NULL'
    add_index :storables, [:name, :parent_id], unique: true
  end
end

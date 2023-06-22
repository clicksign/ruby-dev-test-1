# frozen_string_literal: true

class CreateArchives < ActiveRecord::Migration[7.0]
  def change
    create_table :archives, id: :uuid do |t|
      t.string :name

      t.references :folder, null: true, type: :uuid

      t.uuid :user_id
      t.index :user_id
      t.timestamps
    end
  end
end

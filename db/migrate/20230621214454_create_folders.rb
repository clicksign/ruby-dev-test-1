# frozen_string_literal: true

class CreateFolders < ActiveRecord::Migration[7.0]
  def change
    create_table :folders, id: :uuid do |t|
      t.string :name

      t.references :parent_folder, null: true, foreing_key: { to_table: 'folders' }, type: :uuid

      t.uuid :user_id
      t.index :user_id
      t.timestamps
    end
  end
end

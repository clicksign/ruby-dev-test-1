# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :name
      t.string :password_digest

      t.timestamps
    end
    add_index :users, :name, unique: true
  end
end

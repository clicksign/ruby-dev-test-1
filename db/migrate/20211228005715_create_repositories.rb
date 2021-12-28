# frozen_string_literal: true

class CreateRepositories < ActiveRecord::Migration[6.1]
  def change
    create_table :repositories, id: :uuid do |t|
      t.string :type
      t.string :name
      t.references :origin, type: :uuid, foreign_key: { to_table: 'repositories' }

      t.timestamps
    end
  end
end

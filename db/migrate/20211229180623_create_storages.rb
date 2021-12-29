# frozen_string_literal: true

class CreateStorages < ActiveRecord::Migration[6.1]
  def change
    create_table :storages, id: :uuid do |t|
      t.references :repository, type: :uuid, foreign_key: { to_table: 'repositories' }
      t.binary :document

      t.timestamps
    end
  end
end

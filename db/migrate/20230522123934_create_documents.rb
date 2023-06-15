class CreateDocuments < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :documents, id: :uuid do |t|
      t.string :name, null: false
      t.references :directory, null: false, type: :uuid

      t.timestamps
    end
  end
end

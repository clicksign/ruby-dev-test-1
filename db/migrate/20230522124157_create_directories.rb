class CreateDirectories < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :directories, id: :uuid do |t|
      t.string :name, null: false
      t.references :parent, foreign_key: { to_table: :directories }, type: :uuid

      t.timestamps
    end
  end
end

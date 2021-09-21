class CreateAlbumsPlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :albums_players do |t|
      t.references :album, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true

      t.timestamps
    end
  end
end

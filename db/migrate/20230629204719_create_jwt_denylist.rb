class CreateJwtDenylist < ActiveRecord::Migration[7.0]
  def up
    create_table :jwt_denylists do |t|
      t.string :jti, null: false
      t.datetime :exp, null: false
    end
  end

  def down
    drop_table :jwt_denylists
  end
end

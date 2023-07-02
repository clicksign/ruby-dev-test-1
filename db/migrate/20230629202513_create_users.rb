class CreateUsers < ActiveRecord::Migration[7.0]
  def up
    create_table :users, id: :uuid do |t|
      
      t.string :email,              null: false, default: ''
      t.string :encrypted_password, null: false, default: ''
      
      t.timestamps null: false
    end
  end

  def down
  	drop_table :users
  end
end

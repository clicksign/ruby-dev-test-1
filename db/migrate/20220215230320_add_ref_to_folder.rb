class AddRefToFolder < ActiveRecord::Migration[6.1]
  def change
    add_reference :folders, :ref, foreign_key: { to_table: :folders }
  end
end

class CreateFolders < ActiveRecord::Migration[7.0]
  def change
    create_table :folders do |t|
      t.string :name
      t.references :parent, null: true, foreign_key: { to_table: :folders }

      t.timestamps
    end

    # Cannot add uniqueness to root level as most SQL DBMS
    # does not consider a NULL value equal to other NULL values
    # "For the purposes of unique indices, all NULL values are considered different from all other NULL
    #  values and are thus unique."
    # reference: https://sqlite.org/lang_createindex.html#unique_indexes
    add_index :folders, %i[name parent_id], unique: true
  end
end

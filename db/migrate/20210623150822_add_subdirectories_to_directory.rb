class AddSubdirectoriesToDirectory < ActiveRecord::Migration[6.0]
  def change
    add_reference :directories, :directory, null: true, foreign_key: true
  end
end

class AddProjectIdToDirectory < ActiveRecord::Migration[7.0]
  def change
    add_reference :directories, :project, null: false, foreign_key: true
  end
end

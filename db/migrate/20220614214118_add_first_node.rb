class AddFirstNode < ActiveRecord::Migration[6.1]
  def change
    Node.create!(name: "/", node_type: :directory)
  end
end

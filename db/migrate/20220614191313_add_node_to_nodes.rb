class AddNodeToNodes < ActiveRecord::Migration[6.1]
  def change
    add_reference :nodes, :node, null: true, foreign_key: true
  end
end

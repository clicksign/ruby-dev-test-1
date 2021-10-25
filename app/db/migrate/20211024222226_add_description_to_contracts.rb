class AddDescriptionToContracts < ActiveRecord::Migration[6.1]
  def change
    add_column :contracts, :description, :string
  end
end

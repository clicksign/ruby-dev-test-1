class CreateDirectory < ActiveRecord::Migration[6.1]
  def self.up
    create_table :directories do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :directories
  end
end

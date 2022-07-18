class CreateFileInfos < ActiveRecord::Migration[7.0]
  def change
    create_table :file_infos do |t|
      t.integer :file_system_id
      t.string :type
      t.timestamps
    end
  end
end

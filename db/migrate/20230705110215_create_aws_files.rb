class CreateAwsFiles < ActiveRecord::Migration[7.0]
  def change
    create_table :aws_files do |t|
      t.string :name
      t.string :path
      t.string :url
      t.references :directory, null: false, foreign_key: true

      t.timestamps
    end
  end
end

# frozen_string_literal: true

class CreateFileUploads < ActiveRecord::Migration[6.1]
  unless table_exists? 'file_uploads'
    def change
      create_table :file_uploads do |t|
        t.string :description

        t.timestamps
      end
      add_index :file_uploads, :description
    end
  end
end

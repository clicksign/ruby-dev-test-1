class AddParentIdColumnToFileUpload < ActiveRecord::Migration[6.1]
  if table_exists? 'file_uploads'
    def change
      add_reference :file_uploads, :parent, foreign_key: { to_table: :file_uploads }
    end
  end
end

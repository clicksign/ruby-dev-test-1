class UpdateSizeJob
  include Sidekiq::Job

  def perform(id, parent_id_was = nil)
    folders = Folder.where(id: Folder.find(id).path_ids)
    folders << Folder.where(id: Folder.find(parent_id_was).path_ids) unless parent_id_was.nil?

    ActiveRecord::Base.transaction do
      folders.each do |folder|
        folder.update_column(:trusted_sized, false)
        query_size(folder)
      end
    end
  end

  def query_size(folder)
    folder.children
          .reject(&:trusted_sized)
          .each { |child| query_size(child.id) }
    query = <<-SQL
      SELECT SUM(active_storage_blobs.byte_size)
      FROM active_storage_attachments
      INNER JOIN active_storage_blobs
              ON active_storage_attachments.blob_id = active_storage_blobs.id
      INNER JOIN documents
              ON active_storage_attachments.record_id = documents.id
      INNER JOIN folders
              ON documents.folder_id = folders.id
      WHERE active_storage_attachments.record_type = 'Document' AND
      folders.id = #{folder.id}
    SQL
    byte_size = ActiveRecord::Base.connection.exec_query(query).rows.first.first + folder.children.map(&:byte_size).sum

    folder.update_columns(byte_size:, trusted_sized: true)
  end
end



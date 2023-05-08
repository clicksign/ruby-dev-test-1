class DocumentUtils
  def self.upload(tempfile, *options)
    return false if !valid_param?(options[0], :full_path) || !valid_path?(options[0][:full_path])
    return false if !valid_param?(options[0], :storage)

    folder_path = extract_folder_path(options[0][:full_path])
    document_name = extract_document_name(options[0][:full_path])
    storage_method = "StorageMethods::#{options[0][:storage].capitalize}"

    doc = Document.new(
        name: document_name,
        folder: Folder.path!(folder_path),
        storage_method: storage_method
    )
    doc.upload(tempfile)
  end

  def self.download(full_path)
    return nil if full_path.blank?

    folder_path = extract_folder_path(full_path)
    document_name = extract_document_name(full_path)

    doc = Document.find_by(
        name: document_name,
        folder: Folder.path(folder_path)
    )
    return nil if doc.nil?

    doc.download
  end

  def self.destroy(full_path)
    return nil if full_path.blank?

    folder_path = extract_folder_path(full_path)
    document_name = extract_document_name(full_path)

    doc = Document.find_by(
        name: document_name,
        folder: Folder.path(folder_path)
    )
    return nil if doc.nil?

    doc.destroy
  end

  private
    def self.extract_folder_path(full_path)
      full_path.split('/')[0..-1].join('/')
    end

    def self.extract_document_name(full_path)
      full_path.split('/')[-1]
    end

    def self.valid_param?(param, key)
      param.include?(key) && !param[key].blank?
    end

    def self.valid_path?(full_path)
      full_path.split('/').compact_blank.count >= 2
    end
end
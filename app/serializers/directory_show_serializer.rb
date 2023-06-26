class DirectoryShowSerializer < ApplicationSerializer
  attributes :id,
             :name,
             :path,
             :archives,
             :sub_dirs,
             :parent

  def parent
    return nil unless object&.parent

    DirectoryParentSerializer.new.serialize(object.parent)
  end

  def archives
    return [] if object&.archives&.empty?

    object&.archives.map do |archive|
      ArchiveSerializer.new.serialize(archive)
    end
  end

  def sub_dirs
    return [] if object&.sub_dirs&.empty?

    object&.sub_dirs.map do |sub_dir|
      DirectoryParentSerializer.new.serialize(sub_dir)
    end
  end

  def path
    object&.path
  end
end

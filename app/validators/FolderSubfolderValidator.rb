class FolderSubfolderValidator < ActiveModel::Validator
  def validate(record)
    return true if parent_is_root?(record)

    return true unless parent_is_self_or_children?(record)

    record.errors.add(:parent_folder, 'Cannot move this to a subdirectory of itself.')
  end

  private

  def parent_is_root?(record)
    record.parent_id.nil?
  end

  def parent_is_self_or_children?(record)
    record.parent_id == record.id || record.subtree_children.pluck(:id).include?(record.parent_id)
  end
end

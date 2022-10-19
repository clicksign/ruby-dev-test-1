class Folder < ApplicationRecord
  has_many :children, class_name: 'Folder', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Folder', foreign_key: 'parent_id', optional: true
  validates :name, uniqueness: { scope: :parent_id }
  validate :check_parent
  has_many :documents

  before_validation :check_name
  before_update :update_sizes, if: :parent_id_changed?

  def move(destination_id)
    return if invalid_move(destination_id)

    update(parent_id: destination_id)
  end

  def move!(destination_id)
    raise ArgumentError if invalid_move(destination_id)

    update!(parent_id: destination_id)
  end

  # useful when doing breadcrubms
  def path_ids
    path = [id]
    current = self
    path << current.parent_id until current.parent_id.nil?
    path
  end

  private

  def check_name
    return if same_name_and_parent_folders.empty?

    write_attribute :name, "#{name} (#{find_first_available_number})"
  end

  def check_parent
    return if parent_id.nil?
    return unless parent.nil?

    errors.add(:parent, :invalid)
  end

  def find_first_available_number
    number_arr = same_name_and_parent_folders.pluck(:name)
                                             .map { |word| word[(name.length)..].gsub(/[() ]/, '').to_i }
    i = 1
    loop do
      return i unless number_arr.include? i

      i += 1
    end
  end

  def same_name_and_parent_folders
    self.class.where(parent:).where('name LIKE ?', "#{name}%")
  end

  # checking if is possible to move from one folter to another
  def invalid_move(destination_id)
    destination_id == id || in_subtree?(destination_id:)
  end

  # recursive checking method to verify if destination folder is on folder subtree
  def in_subtree?(destination_id:, is_in_subtree: false)
    return if is_in_subtree

    if children.pluck(:id).include?(destination_id)
      is_in_subtree = true
    else
      # possible performance problem (several queries may be needed)
      children.each { |folder| folder.in_subtree?(destination_id:, is_in_subtree:) }
    end

    is_in_subtree
  end

  # update folder sizes values when parent has changed
  def update_sizes
    ActiveRecord::Base.transaction do
      UpdateSizeJob(id:, parent_id_was:)
    end
  end
end

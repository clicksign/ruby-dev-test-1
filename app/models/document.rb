class Document < ApplicationRecord
  belongs_to :folder
  has_one_attached :file

  before_validation :check_name
  after_create :update_size_count

  private

  def update_size_count
    UpdateSizesJob.perform_async(folder.id)
  end

  def check_name
    return if same_name_and_parent_documents.empty?

    write_attribute :name, "#{name} (#{find_first_available_number})"
  end

  def find_first_available_number
    number_arr = same_name_and_parent_documents.pluck(:name)
                                               .map { |word| word[(name.length)..].gsub(/[() ]/, '').to_i }
    i = 1
    loop do
      return i unless number_arr.include? i

      i += 1
    end
  end

  def same_name_and_parent_documents
    self.class.where(folder_id:).where('name LIKE ?', "#{name}%")
  end
end

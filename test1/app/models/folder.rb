class Folder < ApplicationRecord
  has_closure_tree order: 'name'
  has_many :documents

  validates :name, presence: true
  validates :name, uniqueness: { scope: :parent_id }

  def self.path(folder_path)
    formatted_path = format_path(folder_path)
    return nil if formatted_path.blank?

    find_by_path(formatted_path.split('/'))
  end

  def self.path!(folder_path)
    formatted_path = format_path(folder_path)
    return nil if formatted_path.blank?

    find_or_create_by_path(formatted_path.split('/'))
  end

  def name=(folder_name)
    formatted_name = Folder.format_name(folder_name)
    super(formatted_name)
  end

  private
    def self.format_name(folder_name)
      ascii_path = I18n.transliterate(folder_name)
      ascii_path.delete('^a-zA-Z0-9_-')
    end

    def self.format_path(folder_path)
      ascii_path = I18n.transliterate(folder_path)
      path_without_first_slash = ascii_path.reverse.chomp('/').reverse
      path_with_folder_names_formatted = path_without_first_slash.split('/').map { |folder_name| Folder.format_name(folder_name) }
      path_with_folder_names_formatted.join('/')
    end
end

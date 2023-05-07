class Folder < ApplicationRecord
  has_closure_tree order: 'name'
  has_many :documents

  def self.path(folder_path)
    final_path = I18n.transliterate(folder_path).reverse.chomp('/').reverse.delete('^a-zA-Z0-9/')
    return nil if final_path.blank?

    find_or_create_by_path(final_path.split('/'))
  end
end

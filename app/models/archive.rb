# == Schema Information
#
# Table name: archives
#
#  id         :uuid             not null, primary key
#  file       :string           not null
#  status     :integer          default("active"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  folder_id  :uuid             not null
#
# Indexes
#
#  index_archives_on_folder_id  (folder_id)
#
# Foreign Keys
#
#  fk_rails_...  (folder_id => folders.id)
#
class Archive < ApplicationRecord
  belongs_to :folder

  enum status: %i[active inactive]

  mount_uploader :file, FileUploader

  validates_presence_of :file
  validates_inclusion_of :status, in: %w[active inactive]
end

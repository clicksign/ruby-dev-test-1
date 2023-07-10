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
FactoryBot.define do
  factory :archive do
    status { :active }
    file { Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/example.png", 'image/png') }
    association :folder
  end
end

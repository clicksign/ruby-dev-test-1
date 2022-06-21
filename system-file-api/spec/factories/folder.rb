# frozen_string_literal: true

FactoryBot.define do
  factory :folder, class: 'FolderRecord' do
    sequence(:name) { |n| "Folder #{n}" }
    folder_id { nil }
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :file_item, class: 'FileItemRecord' do
    sequence(:name) { |n| "FileItem #{n}" }
    folder
    after(:build) do |file_item|
      file_item.content.attach(io: File.open(Rails.root.join('db/files/postgres.png')), filename: 'postgres.png',
                               content_type: 'image/png')
    end
  end
end

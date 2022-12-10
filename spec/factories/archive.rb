# frozen_string_literal: true

FactoryBot.define do
  factory :archive do
    association :directory

    trait :with_document do
      after :build do |archive|
        archive.document.attach(
          io: Rack::Test::UploadedFile.new(Rails.root.join('spec/files/first_file.txt')),
          filename: Faker::File.file_name(dir: nil),
          content_type: 'text/plain'
        )
      end
    end

  end
end
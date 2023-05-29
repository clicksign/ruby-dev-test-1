# frozen_string_literal: true

FactoryBot.define do
  factory :storage do
    folder
    sequence(:name) { |n| "file_#{n}" }

    factory :file_s3, class: 'FileModule::S3' do
      folder
      sequence(:name) { |n| "file_#{n}" }
      after(:build) do |file_s3|
        file_s3.attachment.attach(
          io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'sample.txt')),
          filename: 'sample.txt',
          content_type: 'text/plain'
        )
      end
    end

    factory :file_local, class: 'FileModule::Local' do
      folder
      sequence(:name) { |n| "file_#{n}" }
      after(:build) do |file_local|
        file_local.attachment.attach(
          io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'sample.txt')),
          filename: 'sample.txt',
          content_type: 'text/plain'
        )
      end
    end

    factory :file_blob, class: 'FileModule::Blob' do
      folder
      sequence(:name) { |n| "file_#{n}" }
      file_data { 'bla bla bla bla bla' }
    end
  end
end

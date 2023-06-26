FactoryBot.define do
  factory :document do
    sequence(:name) { |num| "Document #{num}" }

    file { Rack::Test::UploadedFile.new(Rails.root.join('test/fixtures/files/leia-message.txt')) }

    file_system
  end
end

FactoryBot.define do
  factory :document do
    title { Faker::File.file_name }
    description { Faker::Lorem.sentence }
    file { Rack::Test::UploadedFile.new("#{Rails.root}/spec/factories/files/file_mock.txt") }
  end
end

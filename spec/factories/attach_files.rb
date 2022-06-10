FactoryBot.define do
  factory :attach_file do
    name { "MyString" }
    file { Rack::Test::UploadedFile.new('spec/fixtures/blob.jpg') }
  end
end

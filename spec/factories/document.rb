FactoryBot.define do
  factory :document do
    folder { create(:folder) }
    name { Faker::Name.name }
    file { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'ebook.pdf')) }
  end
end
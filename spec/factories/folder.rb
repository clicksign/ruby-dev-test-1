FactoryBot.define do
  factory :folder do
    name { Faker::File.file_name }

    transient do
      fixture_file { 'fixture_file.png' }
    end

    trait :with_file_attached do
      before(:create) do |folder, evaluator|
        file_path = File.join(Rails.root, '/spec/fixtures/', evaluator.fixture_file)
        folder.files.attach(io: Rack::Test::UploadedFile.new(file_path, 'image/png'), filename: 'fixture_file.png')
      end
    end
  end
end
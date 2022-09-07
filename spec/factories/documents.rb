FactoryBot.define do
  factory :document do
    title { Faker::File.file_name }
    description { Faker::Lorem.sentence }
    file { Rack::Test::UploadedFile.new("#{Rails.root}/spec/factories/files/file_mock.txt") }
    folder { nil }

    trait :with_folder do
      before :create do |object|
        object.folder = create(:folder_with_user)
      end
    end

    trait :without_file do
      file { nil }
    end

    trait :without_title do
      title { nil }
    end

    trait :without_folder do
      folder { nil }
    end

    factory :document_with_folder, traits: [:with_folder]
    factory :document_without_file, traits: %i[with_folder without_file]
    factory :document_without_title, traits: %i[with_folder without_title]
    factory :document_without_folder, traits: [:without_folder]
  end
end

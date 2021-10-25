require Rails.root.join('spec/support/factory_helpers.rb')

FactoryBot.define do
  factory :folder do
    transient do
      child_folders_amount { 2 }
    end

    name { Faker::Lorem.word }

    trait :with_child_folders do
      after(:create) do |folder, evaluator|
        create_list(:folder, evaluator.child_folders_amount, parent_folder: folder)
      end
    end

    after :create do |folder|
      archive = open_archive_example
      archive2 = open_archive_example
      folder.archives.attach(io: archive[:file],  filename: archive[:filename])
      folder.archives.attach(io: archive2[:file], filename: archive2[:filename])
      folder.save
    end

    factory :folder_with_child_folders, traits: [:with_child_folders]
  end
end

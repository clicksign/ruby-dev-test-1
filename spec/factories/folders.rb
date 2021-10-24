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

    factory :folder_with_child_folders, traits: [:with_child_folders]
  end
end

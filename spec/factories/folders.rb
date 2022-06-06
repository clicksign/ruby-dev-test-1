FactoryBot.define do
  factory :folder do
    parent { nil }
    name { |n| "My folder #{n}" }

    trait :with_documents_and_subfolders do
      after(:create) do |folder|
        3.times do |i|
          create :folder, parent: folder, name: "Subfolder #{i}"
        end
        create :document, folder:
      end
    end
  end
end

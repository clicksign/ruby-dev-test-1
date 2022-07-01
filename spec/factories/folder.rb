FactoryBot.define do
  factory :folder do
    name { 'Folder' }

    trait :sub_folder do
      association :parent, factory: :folder
    end
  end
end

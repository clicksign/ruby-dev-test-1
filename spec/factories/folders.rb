FactoryBot.define do
  factory :folder do
    name { "Folder" }
    
    trait :with_parent do
      association :parent, factory: :folder
    end
  end
end
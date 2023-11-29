FactoryBot.define do
  factory :folder do
    name { Faker::Name.name }
    trait :with_parent do
      parent { parent_id }
    end
  end
end
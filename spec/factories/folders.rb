FactoryBot.define do
  factory :folder do
    label { Faker::Name.unique.name }
  end
end

FactoryBot.define do
  factory :folder do
    name { Faker::Name.first_name }
  end
end

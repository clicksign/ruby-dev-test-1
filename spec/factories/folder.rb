FactoryBot.define do
  factory :folder do
    name { Faker::Lorem.sentence }
    description { Faker::Lorem.sentence }
  end
end

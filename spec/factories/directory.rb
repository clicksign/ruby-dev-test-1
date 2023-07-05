FactoryBot.define do
  factory :directory do
    name { Faker::Lorem.word }
    parent_id { nil }
  end
end

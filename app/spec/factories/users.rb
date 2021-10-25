FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    name { Faker::Name.first_name }
  end
end

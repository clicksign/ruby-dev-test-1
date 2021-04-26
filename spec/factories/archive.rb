FactoryBot.define do
  factory :archive do
    name { Faker::FunnyName.name }
    directory
  end
end
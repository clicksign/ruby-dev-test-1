FactoryBot.define do
  factory :archive do
    folder
    name { Faker::File.name }
  end
end

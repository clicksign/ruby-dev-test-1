FactoryBot.define do
  factory :subdirectory do
    name { Faker::Lorem.word }
    directory { build(:directory) }
  end
end

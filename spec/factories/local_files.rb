FactoryBot.define do
  factory :local_file do
    name { Faker::Name.unique }
  end
end

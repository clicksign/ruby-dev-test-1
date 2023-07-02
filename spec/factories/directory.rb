FactoryBot.define do
  factory :directory, class: Directory do
    association :created_by, factory: :user
    name { Faker::Space.planet }
  end
end

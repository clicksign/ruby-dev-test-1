FactoryBot.define do
  factory :archive, class: Archive do
    association :directory
    association :created_by, factory: :user

    name { Faker::Space.galaxy }
    filename { Faker::Food.spice }
  end
end

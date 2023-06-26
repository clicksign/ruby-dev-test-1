FactoryBot.define do
  factory :directory do
    sequence(:name) { |n| "directory_#{n}" }
    association :user

    trait :with_parent do
      association :parent, factory: :directory
    end
  end
end

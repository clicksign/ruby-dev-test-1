FactoryBot.define do
  factory :directory do
    sequence(:name) { |n| "directory-#{n}" }
    parent { nil }
  end
end

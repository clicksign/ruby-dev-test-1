FactoryBot.define do
  factory :directory do
    sequence(:name) { |n| "Directory #{n}" }

    trait :with_subs do
      after(:create) do |d|
        create_list(:directory, 2, parent: d)
      end
    end

    factory :directory_with_subs, traits: [:with_subs]
  end
end

FactoryBot.define do
  factory :folder do
    user { nil }
    name { 'MyText' }
    parent { nil }

    trait :with_user do
      before :create do |object|
        object.user = create(:user)
      end
    end

    trait :without_name do
      name { nil }
    end

    trait :without_user do
      user { nil }
    end

    factory :folder_with_user, traits: [:with_user]
    factory :folder_without_name, traits: [:with_user, :without_name]
    factory :folder_without_user, traits: [:without_user]
  end
end

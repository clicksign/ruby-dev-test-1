FactoryBot.define do
  factory :folder do
    sequence(:label) { |n| "MyString#{n}" }
  end
end

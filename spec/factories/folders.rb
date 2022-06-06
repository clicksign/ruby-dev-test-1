FactoryBot.define do
  factory :folder do
    parent { nil }
    name { |n| "My folder #{n}" }
  end
end

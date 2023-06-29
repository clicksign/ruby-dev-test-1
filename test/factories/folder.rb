FactoryBot.define do
  factory :folder do
    sequence(:name) { |num| "Folder #{num}" }
  end
end

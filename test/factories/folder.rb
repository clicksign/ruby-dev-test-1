FactoryBot.define do
  factory :folder do
    sequence(:name) { |num| "Folder #{num}" }

    file_system
  end
end

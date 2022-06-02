# frozen_string_literal: true

FactoryBot.define do
  factory :folder do
    name { Faker::Name.unique.name }
    parent { nil }
  end

  factory :folder_file do
    association :folder
  end
end

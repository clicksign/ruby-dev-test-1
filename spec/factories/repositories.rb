# frozen_string_literal: true

FactoryBot.define do
  factory :repository do
    name { Faker::Food.spice }
    association :origin, factory: :repository

    trait :folder do
      initialize_with { Folder.new(attributes) }
    end

    trait :archive do
      initialize_with { Archive.new(attributes) }
    end
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :directory do
    parent { nil }
    name { Faker::Ancient.god }
  end

  trait :with_many_directories do
    after(:create) do |directory|
      create_list(:directory, 5, parent: directory)
      create :document, directory:
    end
  end
end

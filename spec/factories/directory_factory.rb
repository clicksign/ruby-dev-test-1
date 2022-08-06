# frozen_string_literal: true

FactoryBot.define do
  factory :directory do
    name { Faker::Name.first_name }
    slug { name.try(:parameterize) }
  end
end

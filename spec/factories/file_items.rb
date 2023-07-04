# frozen_string_literal: true

FactoryBot.define do
  factory :file_item do
    name { Faker::Science.science }
    directory
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :directory do
    name { Faker::Science.science }
    parent_id { 1 }
  end
end

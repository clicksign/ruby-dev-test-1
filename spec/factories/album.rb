# frozen_string_literal: true

FactoryBot.define do
  factory :directory do
    parent
    name { Faker::Ancient.god }
  end
end

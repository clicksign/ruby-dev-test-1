# frozen_string_literal: true

FactoryBot.define do
  factory :directory do
    sequence(:name) { |n| "Directory#{n}" }
    parent { nil }
  end
end

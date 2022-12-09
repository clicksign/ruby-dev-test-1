# frozen_string_literal: true

FactoryBot.define do
  factory :archive do
    association :directory
  end
end
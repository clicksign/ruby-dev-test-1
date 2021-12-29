# frozen_string_literal: true

FactoryBot.define do
  factory :storage do
    association :repository, factory: :repository
  end
end

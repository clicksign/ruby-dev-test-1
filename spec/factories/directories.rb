# frozen_string_literal: true

FactoryBot.define do
  factory :directory do
    sequence(:name) { |n| "Diretórios-#{n}" }
    parent_id { nil }
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :folder do
    sequence(:name) { |n| "folder_#{n}" }
    parent_folder { nil }
  end
end
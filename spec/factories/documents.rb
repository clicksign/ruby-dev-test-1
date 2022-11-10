# frozen_string_literal: true

FactoryBot.define do
  factory :document do
    sequence(:name) { |n| "Document#{n}" }
    directory { nil }
    content { fixture_file_upload(Rails.root.join('spec/fixtures/filename.xlsx')) }
  end
end

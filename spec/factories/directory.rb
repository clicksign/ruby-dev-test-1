# frozen_string_literal: true

FactoryBot.define do
  factory :directory do
    name { 'test' }
    parent { Directory.top_level.first }
  end
end

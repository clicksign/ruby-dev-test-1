# frozen_string_literal: true

FactoryBot.define do
  factory :directory do
    name { 'MyString' }
    parent_id { 1 }
  end
end

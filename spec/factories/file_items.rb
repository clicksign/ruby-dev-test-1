# frozen_string_literal: true

FactoryBot.define do
  factory :file_item do
    name { 'MyString' }
    content_type { 'MyString' }
    content { 'MyText' }
    directory_id { 1 }
  end
end

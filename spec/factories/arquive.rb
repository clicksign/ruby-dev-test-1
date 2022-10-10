# frozen_string_literal: true

FactoryBot.define do
  factory :arquive do
    directory { Directory.top_level.first }
    name { 'test' }
    persistence { :database }
    data { Rails.root.join('spec/support/files/example.txt') }
  end
end

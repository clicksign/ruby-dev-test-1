# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: 'User' do
    name { Faker::Internet.username }
    password { Faker::Internet.password }
  end
end

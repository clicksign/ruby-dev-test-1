# frozen_string_literal: true

FactoryBot.define do
  factory :directory do
    dirname { Faker::File.dir(segment_count: 1) }

    after :create do |directory|
      create_list(:archive, 2, :with_document, directory:)
    end

    trait :with_subdirectories do
      after :create do |dir|
        create_list(:directory, 3, parent: dir)
      end
    end
  end
end
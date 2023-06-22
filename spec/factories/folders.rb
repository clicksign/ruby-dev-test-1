# frozen_string_literal: true

FactoryBot.define do
  factory :folder, class: 'Folder' do
    name { Faker::File.dir(segment_count: 1) }
    association :user

    trait :with_parent do
      parent { create(:folder, user: user) }
    end

    trait :with_archives do
      after(:create) { |folder| create_list(:archive, 1, :with_file, folder: folder, user: folder.user) }
    end
  end
end

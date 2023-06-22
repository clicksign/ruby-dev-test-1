# frozen_string_literal: true

FactoryBot.define do
  factory :archive, class: 'Archive' do
    name { Faker::File.file_name.split('/').second }
    association :user

    trait :with_folder do
      folder { create(:folder, user: user) }
    end

    trait :with_file do
      before(:create) do |archive|
        archive.file.attach(io: File.open(Rails.root.join('spec/fixtures/test.txt')), filename: 'test.txt')
      end
    end
  end
end

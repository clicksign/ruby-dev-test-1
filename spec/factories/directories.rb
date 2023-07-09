# frozen_string_literal: true

FactoryBot.define do
  factory :directory do
    name { Faker::File.dir(segment_count: 1) }

    trait :as_subdirectory do
      parent { build :directory }
    end

    trait :with_subdirectories do
      transient do
        subdirectories_count { 2 }
      end

      subdirectories { build_list(:directory, subdirectories_count, parent: instance) }
    end

    trait :with_file do
      after(:build) do |directory|
        directory.files.attach(
          io: File.open(Rails.root.join("spec/support/assets/rails.png")),
          filename: "rails.png",
          content_type: "image/png"
        )
      end
    end
  end
end

FactoryBot.define do
  factory :directory do
    name { Faker::File.dir(segment_count: 1) }
    
    after :create do |directory|
      create_list :document, 2, directory: directory
    end

    trait :with_parent do
      association :parent, factory: :directory
    end

    trait :with_subdirectories do
      after :create do |directory|
        create_list :directory, 3, parent: directory
      end
    end
  end
end

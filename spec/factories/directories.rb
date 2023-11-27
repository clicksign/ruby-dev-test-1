FactoryBot.define do
  factory :directory do
    name { Faker::File.dir(segment_count: 1) }

    trait :with_content do
      transient do
        document_count { 1 }
        subdirectories_count { 0 }
      end

      after :create do |directory, evaluator|
        parent_directory = directory

        evaluator.subdirectories_count.times do
          parent_directory = create :directory, parent_directory: parent_directory
        end

        create_list :document, evaluator.document_count, directory: parent_directory
      end
    end
  end
end

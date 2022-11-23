FactoryBot.define do
  factory :directory do
    name { Faker::Name.name }

    trait :with_multiple_subdirectory do
      transient do
        quantity { 3 }
      end

      after(:build) do |directory, evaluator|
        create_list(:directory, evaluator.quantity, parent: directory)
      end
    end

    trait :with_attachment do
      after(:build) do |directory|
        filename = ['image.jpg', 'document.pdf', 'csv-sample.csv'].sample
        directory.files.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'files', filename)), filename: filename)
      end
    end
  end
end

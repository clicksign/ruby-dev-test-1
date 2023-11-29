FactoryBot.define do
  factory :document do
    name { 'image.png' }
    storage_type { %i[database disk s3].sample }

    association :directory, factory: :directory

    trait :with_file do
      transient { file_path { Rails.root.join('spec', 'fixtures', 'files', 'image.png').to_s } }

      after(:build) { |document, evaluator| document.assign_content(evaluator.file_path) }
    end
  end
end

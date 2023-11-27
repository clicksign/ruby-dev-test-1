FactoryBot.define do
  factory :document do
    name { 'image.png' }
    storage_type { %i[database disk s3].sample }

    association :directory, factory: :directory

    trait :with_file do
      transient { file_path { Rails.root.join('spec', 'fixtures', 'files', 'image.png') } }

      after :build do |document, evaluator|
        case document.storage_type.to_sym
        when :database
          document.content = File.read evaluator.file_path
        when :disk
        when :s3
        end
      end
    end
  end
end

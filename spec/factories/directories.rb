FactoryBot.define do
  factory :directory do
    sequence :name do |n|
      "Directory #{n}"
    end

    trait :include_sub do
      after(:create) do |d|
        create_list(:directory, 1, parent: d)
      end
    end

    trait :with_files do
      after(:create) do |d|
        d.files.attach(io: File.open(Rails.root.join('spec/storage', 'img.png')), filename: 'img.png',
                       content_type: 'image/png')
      end
    end

    factory :include_subs, traits: [:include_sub]
    factory :folder
  end
end

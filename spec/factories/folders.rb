# == Schema Information
#
# Table name: folders
#
#  id             :uuid             not null, primary key
#  name           :string(300)      not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  main_folder_id :uuid
#
# Indexes
#
#  index_folders_on_main_folder_id  (main_folder_id)
#  index_folders_on_name            (name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (main_folder_id => folders.id)
#
FactoryBot.define do
  factory :folder do
    name { Faker::Job.title }
    main_folder { nil }

    trait :with_sub_folders do
      transient do
        sub_folders_count { 1 }
      end

      after(:create) do |folder, evaluator|
        create_list(:folder, evaluator.sub_folders_count, main_folder: folder)
      end
    end
  end
end

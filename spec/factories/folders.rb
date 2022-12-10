# frozen_string_literal: true

FactoryBot.define do
  factory :folder do
    name { Faker::Lorem.word }

    trait :with_parent do
      parent { create(:folder) }
    end

    trait :with_documents do
      documents do
        [
          Rack::Test::UploadedFile.new(Rails.root.join("spec/fixtures/FakePDF.pdf"), "application/pdf"),
          Rack::Test::UploadedFile.new(Rails.root.join("spec/fixtures/FakePDF2.pdf"), "application/pdf")
        ]
      end
    end
  end
end

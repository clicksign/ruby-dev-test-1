FactoryBot.define do
  factory :folder do
    name { Faker::Lorem.word }
    parent_id { 1 }

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

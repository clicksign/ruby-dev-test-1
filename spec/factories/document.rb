# frozen_string_literal: true

FactoryBot.define do
  factory :document do
    name { Faker::Ancient.god }
    directory

    after(:build) do |file_import|
      file_import.file.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'document_blank.pdf')),
        filename: 'document.pdf',
        content_type: 'application/pdf'
      )
    end
  end
end

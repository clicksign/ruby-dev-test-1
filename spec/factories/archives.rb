FactoryBot.define do
  factory :archive do
    sequence(:name) {|n| "archive_#{n}"}
    directory
    association :user

    after :build do |archive|
      archive.file.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', 'image-test.png')),
        filename: "image-test.png",
        content_type: "image/png"
      )
    end

    trait :with_doc_attach do
      after :build do |archive|
        archive.file.attach(
          io: File.open(Rails.root.join('spec', 'fixtures', 'doc-test.docx')),
          filename: "doc-test.docx",
          content_type: "application/docx"
        )
      end
    end

    trait :with_pdf_attach do
      after :build do |archive|
        archive.file.attach(
          io: File.open(Rails.root.join('spec', 'fixtures', 'pdf-test.pdf')),
          filename: "pdf-test.pdf",
          content_type: "application/pdf"
        )
      end
    end
  end
end

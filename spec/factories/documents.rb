FactoryBot.define do
  factory :document do
    folder { nil }
    name { |n| "My document #{n}" }

    after :build do |document|
      document.file.attach(
        io: File.open("#{Rails.root}/spec/webmocks/blank.pdf"),
        filename: 'blank.pdf',
        content_type: 'application/pdf',
        identify: false
      )
    end
  end
end

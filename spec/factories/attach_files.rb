FactoryBot.define do
  factory :attach_file do
    name { "My file" }

    after(:build) do |attach_file|
      attach_file.file.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', 'blob.jpg')),
        filename: 'blob.jpg',
        content_type: 'image/jpeg'
      )
    end

    association :folder
  end
end

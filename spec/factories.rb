FactoryBot.define do
  factory :folder do
    name { "folder1" }
    parent { nil }

    factory :folder_with_children do
      after(:create) do |folder|
        FactoryBot.create(:folder, name: "child1", parent: folder)
        FactoryBot.create(:folder, name: "child2", parent: folder)

        folder.files.attach(io: File.open("spec/files/image.png"), filename: "image.png")
        folder.files.attach(io: File.open("spec/files/file.pdf"), filename: "file.pdf")

        folder.save
        folder.reload
      end
    end
  end
end

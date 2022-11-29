image_folder = Directory.create(name: 'images')
document_folder = Directory.create(name: 'documents')

Directory.create(name: 'family_photos', parent: image_folder)
Directory.create(name: 'personal_documents', parent: document_folder)

file_path = "public/files/ransoware.txt"
script = Archive.new(name: 'Hacked!')
script.file.attach(io: File.open(file_path), filename: 'ransoware.txt')
script.directory = document_folder
script.save!
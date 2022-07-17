folder1 = Folder.create(name: 'folder1_with_content')

folder2 = Folder.create(name: 'folder2_with_files')

folder3 = Folder.create(name: 'folder3_empty')

folder4 = Folder.create(name: 'folder4_empty')

archive = Archive.create(name: 'file1')
archive.file.attach(io: File.open('spec/fixtures/lorem-ipsum.pdf'), filename: 'lorem-ipsum.pdf')

archive2 = Archive.create(name: 'file2')
archive2.file.attach(io: File.open('spec/fixtures/lorem-ipsum.pdf'), filename: 'lorem-ipsum.pdf')

folder5 = Folder.create(name: 'folder5_with_content', parent: folder1)
folder6 = Folder.create(name: 'folder6_empty', parent: folder1)

archive3 = Archive.create(name: 'file3', folder: folder1)
archive3.file.attach(io: File.open('spec/fixtures/lorem-ipsum.pdf'), filename: 'lorem-ipsum.pdf')

archive4 = Archive.create(name: 'file4', folder: folder1)
archive4.file.attach(io: File.open('spec/fixtures/lorem-ipsum.pdf'), filename: 'lorem-ipsum.pdf')

folder7 = Folder.create(name: 'folder7', parent: folder5)

archive5 = Archive.create(name: 'file5', folder: folder5)
archive5.file.attach(io: File.open('spec/fixtures/lorem-ipsum.pdf'), filename: 'lorem-ipsum.pdf')

archive6 = Archive.create(name: 'file6', folder: folder5)
archive6.file.attach(io: File.open('spec/fixtures/lorem-ipsum.pdf'), filename: 'lorem-ipsum.pdf')

folder8 = Folder.create(name: 'folder8', parent: folder7)

archive7 = Archive.create(name: 'file7', folder: folder7)
archive7.file.attach(io: File.open('spec/fixtures/lorem-ipsum.pdf'), filename: 'lorem-ipsum.pdf')

archive8 = Archive.create(name: 'file8', folder: folder2)
archive8.file.attach(io: File.open('spec/fixtures/lorem-ipsum.pdf'), filename: 'lorem-ipsum.pdf')

archive9 = Archive.create(name: 'file9', folder: folder2)
archive9.file.attach(io: File.open('spec/fixtures/lorem-ipsum.pdf'), filename: 'lorem-ipsum.pdf')
my_doc = Directory.create(name: "my documents")
videos = Directory.create(name: "videos")
desktop = Directory.create(name: "Desktop")

my_doc.child_binds.create(child_id: videos.id)
my_doc.child_binds.create(child_id: desktop)

videos.archives.create(name: "test_file_1")
videos.archives.create(name: "test_file_2")
videos.archives.create(name: "test_file_3")

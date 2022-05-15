Directory.destroy_all

directory1 = Directory.create(title: 'root')
directory2 = Directory.create(title: 'home', parent: directory1)
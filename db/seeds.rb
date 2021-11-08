# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

root = Folder.create(title: 'root')

n_folders = 3
n_items = 4

(1..n_folders).each do |s|
  subfolder = root.subfolders.create(title: s)
  puts "pasta #{s}"

  (1..n_items).each do |i|
    url = URI.parse("https://picsum.photos/160/90")
    filename = i
    item = subfolder.items.create(name: filename)
    item.file.attach(io: URI.open(url), filename: filename)
    puts "↳ arquivo #{i}"
  end
end

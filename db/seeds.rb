# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

root = Folder.create(title: 'root')
subfolder = root.subfolders.create(title: 'subfolder')

5.times do
  items = root.items.create(name: "file #{rand(1..99)}")
end
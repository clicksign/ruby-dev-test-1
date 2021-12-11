# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

dir1 = Directory.create(name: 'hugo.fonseca')
Directory.create([
                   { name: 'Documents', parent_id: dir1.id },
                   { name: 'Downloads', parent_id: dir1.id },
                   { name: 'Images', parent_id: dir1.id },
                   { name: 'Music', parent_id: dir1.id },
                   { name: 'Movies', parent_id: dir1.id },
                   { name: 'Desktop', parent_id: dir1.id }
                 ])

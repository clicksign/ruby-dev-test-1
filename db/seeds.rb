# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

img_folder = Directory.create(name: 'Images')
doc_folder = Directory.create(name: 'Documentos')

sub_img_folder = Directory.create(name: 'Images de Café', parent: img_folder )
sub_doc_folder = Directory.create(name: 'Notas Mentais', parent: doc_folder)

file_path = "spec/support/archives/amo_café.txt"
coffee_archive = Archive.new(name: 'amo café')
coffee_archive.file.attach(io: File.open(file_path), filename: 'amo_café.txt')
coffee_archive.directory = doc_folder
coffee_archive.save!


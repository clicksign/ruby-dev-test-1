# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

root_directory_exists = Directory.exists?(name: 'root', parent_id: nil)

Directory.new(name: 'root', parent_id: nil).save!(validate: false) unless root_directory_exists

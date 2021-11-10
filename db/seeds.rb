# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create main root folder
root = Folder.create(title: 'Pasta Raiz')

# Set scraping parameters
n_folders = 7
n_items = 4
thumb_width = 400
thumb_ratio = 9 / 16.to_f
thumb_height = (thumb_width * thumb_ratio).to_i

# Progressbar
progressbar = ProgressBar.create(total: n_folders * n_items, format: '%t: |%B| %a %e')

# Create other folders and files
(1..n_folders).each do |s|
  subfolder = root.subfolders.create(title: "Pasta #{s}")
  progressbar.log "→ Pasta #{s}"

  (1..n_items).each do |i|
    url = URI.parse("https://picsum.photos/#{thumb_width}/#{thumb_height}")
    filename = i
    item = subfolder.items.create(name: filename)
    item.file.attach(io: URI.open(url), filename: filename)
    progressbar.log "  ↳ Arquivo #{i}"
    progressbar.increment
  end
end

# Make last folder a subfolder of folder 7 to show multilevel nesting
Folder.last.update(root_id: n_folders)
Folder.last.items.last.destroy
Folder.last.items.last.destroy
Folder.find(n_folders).items.last.destroy

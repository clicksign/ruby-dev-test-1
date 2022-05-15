# frozen_string_literal: true

Directory.destroy_all

directory1 = Directory.create(title: 'root')
Directory.create(title: 'home', parent: directory1)

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Archive, type: :model do
  let(:archive) { create(:archive) }

  describe Archive do
    it "is valid with name" do 
      archive = Archive.create(name: 'File') 

      expect(archive.name).to eq('File') 
    end

    it "is invalid without name" do 
      archive = Archive.new(name: nil)
      archive.valid?
      expect(archive.errors[:name]).to include("can't be blank")
    end

    it "is valid with parent" do 
      archive_child = Archive.create(name: 'File', parent: archive) 

      expect(archive.descendants.count).to be(1)
    end

    it "file upload" do
      archive.files.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', 'teste.pdf')),
        filename: 'teste.pdf',
        content_type: 'application/pdf'
      )

      expect(archive.files).to be_attached
    end
  end
end
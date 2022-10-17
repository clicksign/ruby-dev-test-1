require 'rails_helper'

describe Archive do
  subject{ described_class.new(name: 'file01', folder: folder, file: file) }

  let(:folder) { Folder.create(name: "folder") }
  let(:file) {{
    io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'file_mock.pdf')),
    filename: 'file_mock.pdf'
  }}

  context 'when the archive data is valid' do
    it 'return valid' do
      expect(subject).to be_valid
    end
  end

  context 'when the archive data is invalid' do
    it 'return invalid if without name' do
      subject.name = nil

      expect(subject).not_to be_valid
      expect(subject.errors[:name]).to eq(["can't be blank"])
    end

    it 'return invalid if duplicate names' do
      Archive.create!(name: "file01", folder: folder, file: file )

      expect(subject).not_to be_valid
      expect(subject.errors[:name]).to eq(["has already been taken"])
    end

    it 'return invalid if without file' do
      subject.file = nil

      expect(subject).not_to be_valid
      expect(subject.errors[:file]).to eq(["can't be blank"])
    end
  end
end
require 'rails_helper'

RSpec.describe Archive, type: :model do
  subject { build(:archive) }

  it { is_expected.to belong_to :directory }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:directory_id) }
  it { is_expected.to validate_presence_of(:file) }

  context 'when: the file' do
    it 'is pdf type' do
      invalid_file = Rack::Test::UploadedFile.new(Rails.root.join('spec/support/files/linkedin.pdf'))
      subject.file.attach(io: invalid_file, filename: 'amo-café.pdf')
      subject.valid?
      expect(subject).to_not be_valid
      expect(subject.errors.messages.keys).to include(:file)
      expect(subject.errors.messages[:file]).to include('File type invalid!')
    end
  end
end
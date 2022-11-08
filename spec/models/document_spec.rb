require 'rails_helper'

RSpec.describe Document, type: :model do
  subject { create(:document) }

  it { expect(subject).to(be_valid) }

  describe 'associations' do
    it { expect(subject).to(belong_to(:directory).optional(false)) }
    it { expect(subject).to(have_one_attached(:content)) }
  end

  describe 'validations' do
    it { expect(subject).to(validate_presence_of(:directory)) }
  end

  describe 'getters' do
    let(:file) { subject.content }

    context '#name' do
      it { expect(subject.name).to(eq(file.filename.to_s)) }
    end

    context '#content_type' do
      it { expect(subject.content_type).to(eq(file.content_type.to_s)) }
    end

    context '#size' do
      it { expect(subject.size).to(eq(file.byte_size)) }
    end

    context '#path' do
      it { expect(subject.path).to(eq("#{subject.directory.path}/#{file.filename.to_s}")) }
    end
  end
end

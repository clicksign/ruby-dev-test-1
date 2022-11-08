# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Document do
  subject(:document) { create(:document) }

  it { expect(document).to(be_valid) }

  describe 'associations' do
    it { expect(document).to(belong_to(:directory).optional(false)) }
    it { expect(document).to(have_one_attached(:content)) }
  end

  describe 'getters' do
    let(:file) { document.content }

    describe '#name' do
      it { expect(document.name).to(eq(file.filename.to_s)) }
    end

    describe '#content_type' do
      it { expect(document.content_type).to(eq(file.content_type.to_s)) }
    end

    describe '#size' do
      it { expect(document.size).to(eq(file.byte_size)) }
    end

    describe '#path' do
      it { expect(document.path).to(eq("#{document.directory.path}/#{file.filename}")) }
    end
  end
end

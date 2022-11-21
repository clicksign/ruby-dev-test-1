# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ParentValidator do
  class Dummy < Storable; end

  describe '.validate' do
    let(:dummy) { Dummy.new(name: 'dummy', parent:) }

    context 'when parent is a directory' do
      let(:parent) { Directory.new(name: 'root') }

      it 'returns true' do
        expect(dummy).to be_valid
      end
    end

    context 'when parent is a archive' do
      let(:parent) { Archive.new(name: 'arquivo.txt') }

      it 'returns false and message error' do
        expect(dummy).not_to be_valid
      end

      it 'returns message error' do
        dummy.valid?

        expect(dummy.errors.to_hash).to eq(parent: ['is not a Directory'])
      end
    end
  end
end

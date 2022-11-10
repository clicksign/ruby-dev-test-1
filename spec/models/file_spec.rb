# frozen_string_literal: true

require 'rails_helper'

RSpec.describe File, type: :model do
  # describe 'validations' do
  #   it 'should return invalid if name not present' do
  #     expect(File.new(name: nil)).to be_invalid
  #   end

  #   it 'should return invalid if content not present' do
  #     expect(File.new(content: nil)).to be_invalid
  #   end

  #   it 'should return invalid if directory not present' do
  #     expect(File.new(directory: nil)).to be_invalid
  #   end

  #   it 'should return invalid if name is not unique' do
  #     directory = Directory.create(name: 'test')
  #     File.create(name: 'test', directory:)
  #     expect(File.new(name: 'test', directory:)).to be_invalid
  #   end

  #   it 'should return valid if name is unique' do
  #     directory = Directory.create(name: 'test')
  #     expect(File.new(name: 'test', directory:)).to be_valid
  #   end
  # end
end

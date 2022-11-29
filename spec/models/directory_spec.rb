# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Directory, type: :model do
  it { is_expected.to have_many(:subdirectories).dependent(:destroy) }
  it { is_expected.to belong_to(:parent).class_name('Directory').optional }
  it { is_expected.to validate_presence_of(:name) }
end
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Repository, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:type) }
  it { is_expected.to belong_to(:origin).optional }
end

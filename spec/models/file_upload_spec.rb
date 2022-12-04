# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FileUpload, type: :model do
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_uniqueness_of(:description).case_insensitive }
end

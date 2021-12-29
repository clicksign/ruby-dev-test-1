# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Storage, type: :model do
  it { is_expected.to belong_to(:repository) }
end

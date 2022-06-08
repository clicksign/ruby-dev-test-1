require 'rails_helper'

RSpec.describe Bind, type: :model do
  it { is_expected.to belong_to(:child) }
  it { is_expected.to belong_to(:parent) }
end

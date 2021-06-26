require 'rails_helper'

RSpec.describe Subdirectory, type: :model do
  it { should validate_presence_of(:name) }
  it { should belong_to(:directory) }
end

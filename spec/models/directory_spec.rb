require 'rails_helper'

RSpec.describe Directory, type: :model do
  it { should validate_presence_of(:name) }
end

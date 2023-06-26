require "rails_helper"

RSpec.describe DirectoryParentSerializer, type: :serializer do
  let(:object) { create :directory }
  let(:serializer) { described_class }

  subject { serializer.new.serialize(object) }


  describe "attributes" do
    it { is_expected.to include "id"    => object.id }
    it { is_expected.to include "name"  => object.name }
    it { is_expected.to include "path"  => object.path }
  end
end


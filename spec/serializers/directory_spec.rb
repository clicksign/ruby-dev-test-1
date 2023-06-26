require "rails_helper"

RSpec.describe DirectorySerializer, type: :serializer do
  let(:parent) { create :directory }
  let(:object) { create :directory, parent: parent }
  let!(:sub_dir) { create :directory, parent: object }
  let!(:archives) { create :archive, directory: object }
  let(:serializer) { described_class }

  subject { serializer.new.serialize(object) }

  describe "attributes" do
    it { is_expected.to include "id"        => object.id }
    it { is_expected.to include "name"      => object.name }
    it { is_expected.to include "path"      => object.path }
  end
end


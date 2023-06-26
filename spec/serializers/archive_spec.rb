require "rails_helper"

RSpec.describe ArchiveSerializer, type: :serializer do
  let(:object) { create :archive }
  let(:serializer) { described_class }

  subject { serializer.new.serialize(object) }

  describe "attributes" do
    it { is_expected.to include "id"            => object.id }
    it { is_expected.to include "name"          => object.name }
    it { is_expected.to include "directory_id"  => object.directory_id }
    #pending "url"
    it { is_expected.to include "url"         => object.url }
    it { is_expected.to include "path"          => object.path }
  end
end


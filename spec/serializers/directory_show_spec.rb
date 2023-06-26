require "rails_helper"

RSpec.describe DirectoryShowSerializer, type: :serializer do
  let(:parent) { create :directory }
  let(:object) { create :directory, parent: parent }
  let!(:sub_dir) { create :directory, parent: object }
  let!(:archives) { create :archive, directory: object }
  let(:serializer) { described_class }

  subject { serializer.new.serialize(object) }

  let(:serialized_parent) do
    DirectoryParentSerializer.new.serialize(object&.parent).as_json
  end

  let(:serialized_archives) do
    object&.archives.map do |archive|
      ArchiveSerializer.new.serialize(archive)
    end.as_json
  end

  let(:serialized_sub_dirs) do
    object&.sub_dirs.map do |sub_dir|
      DirectoryParentSerializer.new.serialize(sub_dir)
    end.as_json
  end

  describe "attributes" do
    it { is_expected.to include "id"        => object.id }
    it { is_expected.to include "name"      => object.name }
    it { is_expected.to include "path"      => object.path }
    it { is_expected.to include "parent"    => serialized_parent }
    it { is_expected.to include "archives"  => serialized_archives }
    it { is_expected.to include "sub_dirs"  => serialized_sub_dirs }
  end
end


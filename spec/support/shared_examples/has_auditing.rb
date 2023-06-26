RSpec.shared_examples "has_auditing" do
  context "Auditing" do
    with_versioning do
      it "enables paper trail" do
        is_expected.to be_versioned
      end

      describe "#changeset" do
        it "has expected values" do
          model = create(described_class.name.underscore.parameterize(separator: "_").to_sym)
          changeset = model.versions.last.changeset

          expect(changeset["name"]).to eq([nil, model.name]) if model.respond_to?("name")
          expect(changeset["id"]).to eq([nil, model.id])
          expect(changeset["created_at"][0]).to be_nil
          expect(changeset["created_at"][1].to_i).to eq(model.created_at.to_i)
          expect(changeset["updated_at"][0]).to be_nil
          expect(changeset["updated_at"][1].to_i).to eq(model.updated_at.to_i)
        end
      end
    end
  end
end

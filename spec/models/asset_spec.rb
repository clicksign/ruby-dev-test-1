require 'rails_helper'

RSpec.describe Asset, type: :model do
    context "object creation" do
        it "name should not be empty" do
            asset = FactoryBot.build(:asset, name: "")
            expect(asset.valid?).to eq(false)
        end
        it "file_attachment should not be empty" do
            asset = FactoryBot.build(:asset, file_attachment: nil)
            expect(asset.valid?).to eq(false)
        end
        it "Valid creation"
    end
    context "asset relations" do
        it "test folder relation"
        it "get parent"
    end
end
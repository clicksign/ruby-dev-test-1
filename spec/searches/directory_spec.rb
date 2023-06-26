require "rails_helper"

RSpec.describe DirectorySearch do
  let!(:directories) { create_list :directory, 5 }
  let(:search_params) { {} }

  subject { DirectorySearch.search(Directory, **search_params) }

  describe "sorting" do
    describe "by name" do
      describe "asc" do
        let(:search_params) { { sort: ["name:asc"] } }

        it "returns asc sort by name" do
          expect(subject.result).to match_array directories.sort_by { |a| a.name }
        end
      end

      describe "desc" do
        let(:search_params) { { sort: ["name:desc"] } }

        it "returns desc sort by name" do
          expect(subject.result).to match_array directories.sort_by { |a| a.name }.reverse
        end
      end
    end

    describe "by created_at" do
      describe "asc" do
        let(:search_params) { { sort: ["created_at:asc"] } }

        it "returns asc sort by created_at" do
          expect(subject.result).to match_array directories.sort_by { |a| a.created_at }
        end
      end

      describe "desc" do
        let(:search_params) { { sort: ["created_at:desc"] } }

        it "returns desc sort by created_at" do
          expect(subject.result).to match_array directories.sort_by { |a| a.created_at }.reverse
        end
      end
    end
  end

  describe "searching" do
    before { create_list :directory, 5 }

    describe "fuzzy" do
      let!(:directory) { create :directory, name: "directory_name_000" }

      context "string query" do
        let(:search_params) { { q: "directory_name" } }
        it "returns only with that name" do
          expect(subject.result).to match_array [directory]
        end
      end

      context "array query" do
        let(:search_params) { { q: ["directory_name"] } }
        it "returns only with that name" do
          expect(subject.result).to match_array [directory]
        end
      end

      describe "parent" do
        let(:directory1) { create :directory, name: "directory_name_000" }
        let(:directory2) { create :directory, directory: directory1 }

        let(:search_params) { { q: "directory_name_000" } }

        it "returns result based on query" do
          expect(subject.result).to match_array [directory]
        end
      end
    end

    describe "by name" do
      let(:directory) { create :directory, name: "directory_name_001" }

      context "with single value params" do
        let(:search_params) { { name: directory.name } }

        it "returns only with name" do
          expect(subject.result).to match_array [directory]
        end
      end

      context "with array value params" do
        let(:search_params) { { name: [directory.name] } }

        it "returns only with name" do
          expect(subject.result).to match_array [directory]
        end
      end
    end

    describe "by parent_id" do
      let(:directory1) { create :directory }
      let(:directory2) { create :directory, parent: directory1 }

      context "with single value params" do
        let(:search_params) { { parent_id: directory2.parent_id } }

        it "returns only with parent_id" do
          expect(subject.result).to match_array [directory2]
        end
      end

      context "with array value params" do
        let(:search_params) { { parent_id: [directory2.parent_id] } }

        it "returns only with parent_id" do
          expect(subject.result).to match_array [directory2]
        end
      end
    end
  end
end

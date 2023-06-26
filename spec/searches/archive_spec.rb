require "rails_helper"

RSpec.describe ArchiveSearch do
  let!(:archives) { create_list :archive, 5 }
  let(:search_params) { {} }

  subject { ArchiveSearch.search(Archive, **search_params) }

  describe "sorting" do
    describe "by name" do
      describe "asc" do
        let(:search_params) { { sort: ["name:asc"] } }

        it "returns asc sort by name" do
          expect(subject.result).to match_array archives.sort_by { |a| a.name }
        end
      end

      describe "desc" do
        let(:search_params) { { sort: ["name:desc"] } }

        it "returns desc sort by name" do
          expect(subject.result).to match_array archives.sort_by { |a| a.name }.reverse
        end
      end
    end

    describe "by created_at" do
      describe "asc" do
        let(:search_params) { { sort: ["created_at:asc"] } }

        it "returns asc sort by created_at" do
          expect(subject.result).to match_array archives.sort_by { |a| a.created_at }
        end
      end

      describe "desc" do
        let(:search_params) { { sort: ["created_at:desc"] } }

        it "returns desc sort by created_at" do
          expect(subject.result).to match_array archives.sort_by { |a| a.created_at }.reverse
        end
      end
    end
  end

  describe "searching" do
    before { create_list :archive, 5 }

    describe "fuzzy" do
      let!(:archive) { create :archive, name: "archive_name_000" }

      context "string query" do
        let(:search_params) { { q: "archive_name" } }
        it "returns only with that name" do
          expect(subject.result).to match_array [archive]
        end
      end

      context "array query" do
        let(:search_params) { { q: ["archive_name"] } }
        it "returns only with that name" do
          expect(subject.result).to match_array [archive]
        end
      end

      describe "directory" do
        let(:directory) { create :directory, name: "directory_name_000" }
        let(:archive) { create :archive, directory: directory }

        let(:search_params) { { q: "directory_name_000" } }

        it "returns result based on query" do
          expect(subject.result).to match_array [archive]
        end
      end
    end

    describe "by name" do
      let(:archive) { create :archive, name: "archive_name_001" }

      context "with single value params" do
        let(:search_params) { { name: archive.name } }

        it "returns only with name" do
          expect(subject.result).to match_array [archive]
        end
      end

      context "with array value params" do
        let(:search_params) { { name: [archive.name] } }

        it "returns only with name" do
          expect(subject.result).to match_array [archive]
        end
      end
    end

    describe "by directory_id" do
      let(:directory) { create :directory }
      let(:archive) { create :archive, directory: directory }

      context "with single value params" do
        let(:search_params) { { directory_id: archive.directory_id } }

        it "returns only with directory_id" do
          expect(subject.result).to match_array [archive]
        end
      end

      context "with array value params" do
        let(:search_params) { { directory_id: [archive.directory_id] } }

        it "returns only with directory_id" do
          expect(subject.result).to match_array [archive]
        end
      end
    end
  end
end

require 'rails_helper'

RSpec.describe Directory, type: :model do
  it_behaves_like 'nameable' do
    subject { create(:directory) }
  end

  describe 'associations' do
    it do
      is_expected.to belong_to(:parent).class_name('Directory').optional
    end
    it do
      is_expected.to have_many(:children).class_name('Directory')
                     .with_foreign_key('parent_id')
    end
    it { is_expected.to have_many(:archives) }
  end

  describe 'callbacks' do
    describe 'update full path' do
      context 'when parent is empty' do
        let(:directory) { build(:directory, parent: nil) }
        it do
          expect { directory.save }.to change(directory, :full_path)
                                       .from(nil).to("/#{directory.name}")
        end
      end

      context 'when have parent' do
        let(:parent) { create(:directory) }
        let(:directory) { build(:directory, parent: parent) }

        it do
          expect { directory.save }.to change(directory, :full_path)
                                       .from(nil).to("#{parent.full_path}/"\
                                        "#{directory.name}")
        end
      end

      context 'when update name update full_path' do
        let(:old_name) { Faker::Fantasy::Tolkien.character }
        let(:new_name) { Faker::Fantasy::Tolkien.character }
        let(:directory) { create(:directory, name: old_name, parent: nil) }
        let(:update_name) { directory.update(name: new_name) }

        it do
          expect { update_name }.to change(directory, :full_path)
                                    .from("/#{old_name}")
                                    .to("/#{new_name}")
        end
      end
    end

    describe 'update children full path' do
      context 'when name is updated' do
        let(:old_name) { Faker::Fantasy::Tolkien.character }
        let(:new_name) { Faker::Fantasy::Tolkien.character }
        let(:directory) { create(:directory, name: old_name, parent: nil) }
        let(:child1) { build(:directory) }
        let(:child2) { build(:directory) }
        let(:update_name) { directory.update(name: new_name) }

        before do
          directory.children << child1
          directory.children << child2
        end

        it do
          expect { update_name }.to change { child1.reload.full_path }
                                    .from("/#{old_name}/#{child1.name}")
                                    .to("/#{new_name}/#{child1.name}")
                                    .and(
                                      change { child2.reload.full_path }
                                      .from("/#{old_name}/#{child2.name}")
                                      .to("/#{new_name}/#{child2.name}")
                                    )
        end
      end
    end
  end
end

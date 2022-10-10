# frozen_string_literal: true

# == Schema Information
#
# Table name: arquives
#
#  id           :bigint           not null, primary key
#  data         :binary
#  name         :string
#  path         :string
#  persistence  :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  directory_id :bigint           not null
#
# Indexes
#
#  index_arquives_on_directory_id  (directory_id)
#
# Foreign Keys
#
#  fk_rails_...  (directory_id => directories.id)
#
class Arquive < ApplicationRecord
  belongs_to :directory

  validates :name,
            :persistence,
            :data,
            presence: true

  before_save :persist_data!, if: :external_persistance?
  before_save :read_data, unless: :external_persistance?

  enum persistence: {
    database: 0,
    local: 1,
    cloud: 2
  }

  def external_persistance?
    %i[local cloud].include?(persistence.to_sym)
  end

  def file
    __send__("#{persistence}_file".to_sym)
  end

  def as_json(*)
    super.except('data')
  end

  private

  def read_data
    self.data = data.read
  end

  def persist_data!
    updated_path = __send__("persist_#{persistence}_data".to_sym)

    self.data = nil
    self.path = updated_path
  end

  def persist_local_data
    DiskService.create_file!(data)
  end

  def persist_cloud_data
    BucketService.create_file!(data)
  end

  def local_file
    DiskService.get_file(path)
  end

  def cloud_file
    BucketService.get_file(path)
  end

  def database_file
    DiskService.create_file!(data)
  end
end

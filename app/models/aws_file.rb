# == Schema Information
#
# Table name: aws_files
#
#  id           :bigint           not null, primary key
#  name         :string
#  path         :string
#  url          :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  directory_id :bigint           not null
#
# Indexes
#
#  index_aws_files_on_directory_id  (directory_id)
#
# Foreign Keys
#
#  fk_rails_...  (directory_id => directories.id)
#
class AwsFile < ApplicationRecord
  belongs_to :directory

  def download_url
    obj = S3_BUCKET.object(url)
    obj.presigned_url(:get)
  end
end

require 'net/http'
require 'uri'

class UploadJob < ApplicationJob
  queue_as :uploads

  def perform(objects_to_upload)
    puts "\n\n [√] working -> "
    upload = Upload.new(title: objects_to_upload[:title], info: objects_to_upload[:info])
    upload.save
  end
end
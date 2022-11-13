class UploadJob < ApplicationJob
  queue_as :uploads

  def perform(signed_objects)
    puts "\n--->"
    puts "#{signed_objects}"
    puts "\nat upload job\n"
  end
end

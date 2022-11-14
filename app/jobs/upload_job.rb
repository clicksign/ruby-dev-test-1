require 'net/http'
require 'uri'

class UploadJob < ApplicationJob
  queue_as :uploads

  def perform(objects_to_upload)
    puts "\n\n [√] working -> "
    puts objects_to_upload

    send_file = -> (file_info) {

      puts "\n-> running UploadJob\n"
      headers = file_info[:signed_object][:direct_upload][:headers]
      url = URI.parse(file_info[:signed_object][:direct_upload][:url])
      req = Net::HTTP::Put.new(url.to_s)

      puts "https://#{url.host}#{url.path}#{url.query}"

      req["Connection"] = 'keep-alive'
      req["Content-MD5"] = headers['Content-MD5']
      req["Content-Disposition"] = headers['Content-Disposition']
      req["Content-Type"] = file_info[:content_type]
      req.body = file_info[:file]

      Net::HTTP.start(url.host) do |http|
        result = http.send_request('PUT', url, file_info[:file], headers)
        puts "\n---> #{result.response} - #{result.code} - #{result.message}"
      end
    }

    objects_to_upload.each do |signed_object|
      upload_object = signed_object
      send_file.call(upload_object)
    end

  end
end
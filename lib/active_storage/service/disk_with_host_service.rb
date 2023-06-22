# frozen_string_literal: true

require 'active_storage/service/disk_service'

class ActiveStorage::Service::DiskWithHostService < ActiveStorage::Service::DiskService
  def url_options
    { host: 'http://example.com' }
  end
end

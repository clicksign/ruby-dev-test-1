module Directories
  class UpdateService < ApplicationService
    attr_reader :directory_id, :directory_params

    def initialize(**params)
      @directory_id = params.delete(:directory_id)
      @directory_params = params
    end

    def call
      directory.update(**directory_params)
    end

    private

    def directory
      @directory ||= Directory.find!(directory_id)
    end
  end
end

module Directories
  class CreateService < ApplicationService
    attr_reader :directory_params

    def initialize(**params)
      @directory_params = params
    end

    def call
      Directory.create!(directory_params)
    end
  end
end

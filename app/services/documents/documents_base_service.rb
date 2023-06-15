module Documents
  class DocumentsBaseService < ApplicationService
    attr_reader :provider

    def provider_class
      @provider_class ||= "Documents::#{provider.camelize}Document".constantize
    end
  end
end

module Documents
  class UpdateService < DocumentsBaseService
    attr_reader :document_params

    def initialize(**params)
      @document_id = params.delete(:document_id)
      @provider = params.delete(:provider)
      @document_params = params
    end

    def call
      document.update(**document_params)
    end

    private

    def document
      @document ||= provider_class.find(document_id)
    end

    def directory
      @directory ||= Directory.find(directory_id)
    end
  end
end

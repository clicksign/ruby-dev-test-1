module Documents
  class CreateService < DocumentsBaseService
    attr_reader :document_params

    def initialize(params)
      @provider = params.delete(:provider)
      @document_params = params
    end

    def call
      provider_class.create!(**document_params)
    end

    private

    def directory
      @directory ||= Directory.find(directory_id)
    end
  end
end

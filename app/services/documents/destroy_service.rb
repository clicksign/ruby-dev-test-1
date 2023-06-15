module Documents
  class DestroyService < DocumentsBaseService
    attr_reader :document_id

    def initialize(document_id:, provider:)
      @document_id = document_id
      @provider = provider
    end

    def call
      provider_class.destroy!
    end

    private
    
    def document
      @document ||= provider_class.find(document_id)
    end
  end
end

module Documents
  class DestroyService < DocumentsBaseService
    attr_reader :document_id

    def initialize(params)
      @document_id = params[:document_id]
      @provider = params[:provider]
    end

    def call
      document.destroy!
      document
    end

    private
    
    def document
      @document ||= provider_class.find(document_id)
    end
  end
end

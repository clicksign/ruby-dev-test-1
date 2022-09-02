module ApplicationManager    
  class GetEnsuredFileParamsService
    def initialize(param)
      @param = param
    end

    def call            
      get_ensured_file
    end

    private

    def get_ensured_file
      if ApplicationManager::CheckBase64Service.new(@param).call
        ApplicationManager::DecodeBase64Service.new(@param).call
      else
        @param
      end
    end
  end
end
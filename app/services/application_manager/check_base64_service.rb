module ApplicationManager    
  class CheckBase64Service
    def initialize(str)
      @str = str
    end

    def call            
      is_base64?
    end

    private
    
    def is_base64?
      @str.is_a?(String) && Base64.strict_encode64(Base64.decode64(@str.split(',')[1])) == @str.split(',')[1]
    end
  end
end
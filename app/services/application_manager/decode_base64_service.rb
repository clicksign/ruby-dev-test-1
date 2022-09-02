module ApplicationManager    
  class DecodeBase64Service
    def initialize(str)
      @str = str
    end

    def call
      decode_base64 
    end

    private

    def decode_base64
      decoded_data = Base64.decode64(@str.split(',')[1])
      {
        io: StringIO.new(decoded_data),
        content_type: 'image/jpeg',
        filename:  "upload-#{Time.current.to_i}.jpg"
      }
    end
  end
end

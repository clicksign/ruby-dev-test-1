module RequestsTestHelper
  module Methods
    # método para facilitar acesso ao retorno das requisições (JSON)
    def response_data(reload: false)
      return @response_data if @response_data && !reload

      @response_data = JSON.parse response.body
    end
  end
end

RSpec.configure do |config|
  config.include RequestsTestHelper::Methods, type: :request
  config.include RequestsTestHelper::Methods, type: :controller
end

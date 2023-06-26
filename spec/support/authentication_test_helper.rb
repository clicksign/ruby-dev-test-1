# frozen_string_literal: true

module AuthenticationTestHelper
  module Methods
    def basic_authentication!(user: nil)
      @current_user = user || create(:user)

      allow_any_instance_of(described_class).to receive(:authenticate_user!).and_return(@current_user)

      ActsAsTenant.current_tenant = @current_user
      ActsAsTenant.test_tenant = @current_user
    end

    def reset_authentication!
      # removendo stubs, com "#and_call_original"
      %i[
        authenticate_user!
      ].each do |method_name|
        allow_any_instance_of(described_class).to receive(method_name).and_call_original
      end

      ActsAsTenant.current_tenant = nil
      ActsAsTenant.test_tenant = nil
    end
  end
end


RSpec.configure do |config|
  config.include AuthenticationTestHelper::Methods, type: :request
  config.include AuthenticationTestHelper::Methods, type: :controller
end

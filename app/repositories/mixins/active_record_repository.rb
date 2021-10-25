module Mixins::ActiveRecordRepository
  extend ActiveSupport::Concern

  module ClassMethods
    def method_missing(method_name, *args, &block)
      super unless target_model.respond_to?(method_name)

      target_model.public_send(method_name, *args, &block)
    end

    def respond_to_missing?(method_name, include_private = false)
      super || target_model.respond_to?(method_name, include_private)
    end
  end
end

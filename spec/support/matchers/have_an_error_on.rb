# frozen_string_literal: true

##
# Matcher to test error and message on attribute
#
# Usage:
#
#   expect(subject).to have_an_error_on(attribute_name)
#   expect(subject).to have_an_error_on(attribute_name).with_message(message, options)
#
RSpec::Matchers.define :have_an_error_on do |attribute|
  match do |object|
    if @message
      object.errors.added?(attribute, @message, @options)
    else
      object.errors.include?(attribute)
    end
  end

  chain :with_message do |message, options = {}|
    @message = message
    @options = options
  end
end

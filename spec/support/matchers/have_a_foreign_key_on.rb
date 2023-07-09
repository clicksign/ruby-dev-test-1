# frozen_string_literal: true

##
# Test for existence of Postgresql DB foreign keys
#
# Usage:
#   is_expected.to have_a_foreign_key_on(:attribute)
#   is_expected.to have_a_foreign_key_on(:attribute).with_name(:fk_name)
#
RSpec::Matchers.define :have_a_foreign_key_on do |attribute|
  match do |actual|
    actual.send("#{attribute}=", -1)

    expect { actual.save validate: false }.to raise_error(ActiveRecord::StatementInvalid) do |error|
      @error_message = error.message

      expect(@error_message).to match("PG::ForeignKeyViolation").and match(/(Key \(#{attribute}\)=)/m)
      expect(@error_message).to match("constraint \"#{@fk_name}\"") if @fk_name
    end
  end

  failure_message do |actual|
    if @error_message
      "The database detects a foreign key violation and returns with\n#{@error_message}"
    else
      message = "Database did not catch foreign key violation for ##{attribute} of table '#{actual.class.table_name}'"
      message += " expected to have a foreign key named '#{@fk_name}'" if @fk_name

      message
    end
  end

  chain :with_name do |fk_name|
    @fk_name = fk_name
  end
end

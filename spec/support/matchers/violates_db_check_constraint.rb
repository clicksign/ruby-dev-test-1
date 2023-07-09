# frozen_string_literal: true

##
# Test a Postgresql db constraint
#
# Usage:
#   is_expected.to violates_db_check_constraint("constraint name")
#
RSpec::Matchers.define :violates_db_check_constraint do |expected|
  match do |actual|
    expect { actual.save validate: false }.to raise_error(ActiveRecord::StatementInvalid) do |error|
      @error_message = error.message
      expect(error.message).to match("PG::CheckViolation").and match("check constraint \"#{expected}\"")
    end
  end

  failure_message do |actual|
    if @error_message
      "Database responds with #{@error_message}"
    else
      "Database did not catch invalid value for table '#{actual.class.table_name}' \
      expected to have a check constraint named '#{expected}'.\n"
    end
  end
end

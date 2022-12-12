# frozen_string_literal: true

class DirectorySerializer < BaseSerializer
  fields :id, :dirname

  association :subdirectories, blueprint: DirectorySerializer
end

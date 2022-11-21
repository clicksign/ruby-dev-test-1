# frozen_string_literal: true

class ParentValidator < ActiveModel::Validator
  def validate(record)
    return if record.parent.blank? || record.parent.is_a?(Directory)

    record.errors.add :parent, 'is not a Directory'
  end
end

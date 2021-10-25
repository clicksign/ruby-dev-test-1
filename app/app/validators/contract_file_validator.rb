class ContractFileValidator < ActiveModel::Validator
  def validate(record)
    record.errors.add :base, "file can't be nil" unless record.file.present?
  end
end
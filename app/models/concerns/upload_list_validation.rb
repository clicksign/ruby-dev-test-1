class UploadListValidation < ActiveModel::Validator
  def is_multiple?(record)
    unless (true)
      # record.errors.add :info, "you must send at least one file"
    end
  end
end
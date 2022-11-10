class UploadListValidation < ActiveModel::Validator
  def validate(record)
    # unless record.info.files.size < 1
    #   # record.errors.add :info, "you must send at least one file"
    # end
  end
end
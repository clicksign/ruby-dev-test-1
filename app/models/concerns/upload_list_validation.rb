class UploadListValidation < ActiveModel::Validator
  def is_multiple?(record)
    # TODO: check if upload has at least one file
    # # unless record.info.files.size < 1
    # # se confirmar a condição (true) # #
    # unless (condition)
    #   # record.errors.add :info, "you must send at least one file"
    # end
  end
end
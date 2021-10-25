class ContractUploader < ApplicationUploader
  def store_dir
    "user/#{model.user.id}/contracts/#{model.id}"
  end

  def extension_allowlist
    %w(pdf)
  end
end
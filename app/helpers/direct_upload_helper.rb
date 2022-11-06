module DirectUploadHelper
  require 'faker'

  def random_directory
    Faker::House.furniture
  end

end

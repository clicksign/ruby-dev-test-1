module Users
  class Poro
    attr_accessor :id, :email

    def initialize(user)
      @id = user.id
      @email = user.email
    end
  end
end

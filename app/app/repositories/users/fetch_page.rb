module Users
  class FetchPage
    def self.list(page: nil)
      Users::ListPoro.new users.page(page || 1).per(25)
    end

    private

    def self.users
      User.where(nil)
    end
  end
end

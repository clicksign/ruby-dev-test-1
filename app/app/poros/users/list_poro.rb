module Users
  class ListPoro
    attr_accessor :list

    def initialize(users)
      @list = users.map do |user|
        Users::Poro.new user
      end
    end
  end
end

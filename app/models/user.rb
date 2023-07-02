class User < ApplicationRecord
  
  devise :database_authenticatable,   :jwt_authenticatable,  :registerable,
         :rememberable, jwt_revocation_strategy: JwtDenylist

  validates :email, presence: true
  validates :email, format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates_uniqueness_of :email

  has_many :directories
  has_many :archives

end
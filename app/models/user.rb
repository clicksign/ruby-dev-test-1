class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :folders, dependent: :destroy

  after_commit :create_root_folder, on: :create

  def create_root_folder
    folders.create(name: 'Root')
  end
end

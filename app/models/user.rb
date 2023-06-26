# annotate
# ---
# == Schema Information
#
# Table name: users
#
#  id              :uuid             not null, primary key
#  email           :string           not null
#  name            :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
# ---
class User < ApplicationRecord
  # Secure Password
  # ---
  has_secure_password

  # Validations
  # ---
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  # Associations
  # ---
  has_many :directories, dependent: :destroy
  has_many :archives, dependent: :destroy
end

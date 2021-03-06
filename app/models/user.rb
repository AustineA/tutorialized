class User < ApplicationRecord
  has_secure_password
  has_one_attached :avatar

  has_many :courses, dependent: :destroy
  has_many :lessons, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :username, presence: true, :uniqueness => true
	validates :email, presence: true, :uniqueness => true
end

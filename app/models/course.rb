class Course < ApplicationRecord
  include Variant
  self.implicit_order_column = "created_at"

  has_one_attached :cover
  has_one_attached :intro
  has_one_attached :poster



  belongs_to :user
  has_many :lessons, dependent: :destroy
  has_many :orders
end

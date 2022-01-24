class Lesson < ApplicationRecord
  include Variant

  self.implicit_order_column = "created_at"
  has_one_attached :video
  has_one_attached :cover
  
  
  belongs_to :course, :counter_cache => true
  belongs_to :user

  validates :title, presence: true
  validates :video, attached: true
  validates :cover, attached: true
end

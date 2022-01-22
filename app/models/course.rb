class Course < ApplicationRecord
  self.implicit_order_column = "created_at"
  mount_uploader :cover, CoverUploader
  mount_uploader :intro, IntroUploader
  mount_uploader :poster, PosterUploader



  belongs_to :user
  has_many :lessons, dependent: :destroy
  has_many :orders
end

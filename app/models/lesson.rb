class Lesson < ApplicationRecord
  self.implicit_order_column = "created_at"
  mount_uploader :cover, CoverImageUploader
  mount_uploader :video, VideoUploader
  
  belongs_to :course, :counter_cache => true
  belongs_to :user

end

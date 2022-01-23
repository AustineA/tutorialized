class Order < ApplicationRecord
  self.implicit_order_column = "created_at"
  belongs_to :course
  belongs_to :user
end

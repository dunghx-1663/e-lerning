class Activity < ApplicationRecord
  belongs_to :user
  scope :belongs, ->user_id{where user_id: user_id}
  scope :order_date_desc, ->{order created_at: :desc}
  enum contnet: [:follow, :unfollow, :create_lesson]
end

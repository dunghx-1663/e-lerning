class Category < ApplicationRecord
  has_many :words, dependent: :restrict_with_exception
  has_many :lessons, dependent: :destroy

  validates :name, presence: true, length: {maximum: Settings.category_name}
  validates :description, length: {maximum: Settings.category_des}
  scope :order_date_desc, ->{order created_at: :desc}

end

class Product < ApplicationRecord
  belongs_to :category
  has_many :order_items
  has_many :reviews
  has_one_attached :image

  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "created_at", "description", "id", "name", "price", "updated_at"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["category", "image_attachment", "image_blob", "order_items", "reviews"]
  end
end

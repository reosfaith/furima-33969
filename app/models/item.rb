class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category, :condition, :shipping_cost ,:shipping_area, :shipping_date
  belongs_to :user
  has_one_attached :image

  validates :product_name, :price, :description, :category_id, :condition_id, :shipping_cost_id, :shipping_area_id, :shipping_date_id, :image, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 300 }
  validates :price, numericality: { less_than_or_equal_to: 9999999 }
  validates :price, format: { with: /\A[0-9]+\Z/ }
  validates :category_id, :condition_id, :shipping_cost, numericality: { other_than: 1 }

end

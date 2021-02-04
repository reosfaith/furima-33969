class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_cost
  belongs_to :shipping_area
  belongs_to :shipping_date
  belongs_to :user
  has_one :order
  has_one_attached :image

  validates :product_name, :price, :description, :category_id, :condition_id, :shipping_cost_id, :shipping_area_id,
            :shipping_date_id, :image, presence: true
  validates :price,
            numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,
                            message: 'must be hankaku-number and between ¥300~¥9,999,999' }
  validates :category_id, :condition_id, :shipping_cost_id, :shipping_area_id, :shipping_date_id, numericality: { other_than: 1 }
end

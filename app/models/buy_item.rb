class BuyItem
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city, :house_number, :building_name, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :city, :house_number, :token, :user_id, :item_id
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :post_code, format: {with: /\A\d{3}[-]\d{4}\Z/, message: "must be number includes hypen" }
    validates :phone_number, format: {with: /\A[0-90-9]{1,11}\Z/, message: "must be number within 11 characters"}
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Destination.create(post_code: post_code, prefecture_id: prefecture_id, city: city, house_number: house_number, building_name: building_name, phone_number: phone_number, order_id: order.id)
  end

end
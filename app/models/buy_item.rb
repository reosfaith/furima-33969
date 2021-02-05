class BuyItem
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city, :house_number, :building_name, :phone_number, :user_id, :item_id,:card_number, :card_exp_month, :card_exp_year, :card_cvc

  with_options presence: true do
    validates :post_code, format: {with: /\A\d{3}[-]\d{4}\Z/ }
    validates :prefecture_id, :city, :house_number
    validates :phone_number, format: {with: /\A[0-9０-９]+\Z/, message: "must be number"}
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Destination.create(post_code: post_code, prefecture_id: prefecture_id, city: city, house_number: house_number, building_name: building_name, phone_number: phone_number, order_id: order.id)
  end

end
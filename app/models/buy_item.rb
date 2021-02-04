class BuyItem
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city, :house_number, :building_name, :phone_number, :user, :item

  with_options presence: true do
    validates :post_code, format: {with: /\A\d{3}[-]\d{4}\Z/ }
    validates :prefecture_id, :city, :house_number, :phone_number, :user, :item
  end

  def save
    Order.create(user_id: user.id, item_id: item.id)
    Destination.create(post_code: post_code, prefecture_id: prefecture_id, city: city, house_number: house_number, building_name: building_name, phone_number: phone_number)
  end

end
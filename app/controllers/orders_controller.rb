class OrdersController < ApplicationController

  def index
    @buy_item = BuyItem.new
  end

  def create
    @buy_item = BuyItem.new(item_params)

  end

  private

  def item_params
    params.require(:order).permit(:post_code, :prefecture_id, :city, :house_number, :building_name, :phone_number)
  end
end

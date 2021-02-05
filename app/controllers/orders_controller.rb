class OrdersController < ApplicationController

  def index
    @item = Item.find(params[:item_id])
    @buy_item = BuyItem.new
  end

  def create
    @buy_item = BuyItem.new(item_params)
    if @buy_item.valid?
      @buy_item.save
      redirect_to item_orders_path(params[:item_id])
    else
      @item = Item.find(params[:item_id])
      render :index
    end
  end

  private

  def item_params
    params.require(:buy_item).permit(:post_code, :prefecture_id, :city, :house_number, :building_name, :phone_number, :card_number, :card_exp_month, :card_exp_year, :card_cvc).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end

class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :find_item, only: [:index, :create]
  before_action :sold_out, only: [:index, :create]

  def index
    @buy_item = BuyItem.new
    if @item.user.id == current_user.id
      redirect_to :root
    end
  end

  def create
    @buy_item = BuyItem.new(item_params)
    if @buy_item.valid? && @item.user.id != current_user.id
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

  def find_item
    @item = Item.find(params[:item_id])
  end

  def sold_out
    if @item.order.present?
      redirect_to :root
    end
  end
end

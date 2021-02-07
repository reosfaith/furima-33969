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
      pay_item
      @buy_item.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def item_params
    params.require(:buy_item).permit(:post_code, :prefecture_id, :city, :house_number, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def find_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: item_params[:token],
      currency: 'jpy'
    )
  end

  def sold_out
    if @item.order.present?
      redirect_to root_path
    end
  end
end

class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :update, :destroy]

  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to :root
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])

  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    if item.save
      redirect_to item_path(params[:id])
    else
      render  :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:product_name, :image, :price, :description, :category_id, :condition_id, :shipping_cost_id,
                                 :shipping_area_id, :shipping_date_id).merge(user_id: current_user.id)
  end

  def move_to_index
    item = Item.find(params[:id])
    unless current_user.id == item.user.id
      redirect_to action: index
    end
  end
end

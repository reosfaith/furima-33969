class ItemsController < ApplicationController
  before_action :authenticate_user!, only: :new

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to :root
    else
      render new_item_path
    end
  end

  private

  def item_params
    params.require(:item).permit(:product_name, :image, :price, :description, :category_id, :condition_id, :shipping_cost_id,
                                 :shipping_area_id, :shipping_date_id).merge(user_id: current_user.id)
  end
end

class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  private
  def item_params
    params.require(:item).permit(:product_name, :price, :description, :category_id, :condition_id, :shipping_cost_id, :shipping_area_id, :shipping_date_id, :image).merge(user_id: current_user.id)
  end
end

class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_prams)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_prams
    params.require(:item).permit(
      :image, :item_name, :description, :category_id, :status_id, :shipping_fee_responsibility_id,
      :prefecture_id, :lead_time_id, :price).merge(user_id: current_user.id
    )
  end




end

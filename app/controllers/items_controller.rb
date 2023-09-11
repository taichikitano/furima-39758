class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_prototype, except: [:index, :new, :create]
  before_action :contributor_confirmation, only: [:edit, :update, :destroy]
  before_action :move_to_root, only: [:edit, :destroy]
  
  def index 
    @items = Item.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(
      :image, :item_name, :description, :category_id, :status_id, :shipping_fee_responsibility_id,
      :prefecture_id, :lead_time_id, :price).merge(user_id: current_user.id
    )
  end

  def set_prototype
    @item = Item.find(params[:id])
  end
  
  def contributor_confirmation
    redirect_to root_path unless current_user == @item.user
  end

  def move_to_root
    redirect_to root_path if @item.purchase.present?
  end

end

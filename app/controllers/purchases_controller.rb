class PurchasesController < ApplicationController
  before_action :set_prototype
  before_action :authenticate_user!
  before_action :contributor_confirmation
  before_action :move_to_root


  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @purchase_shipping = PurchaseShipping.new
  end

  def create
    @purchase_shipping = PurchaseShipping.new(purchase_params)
    if @purchase_shipping.valid?
      pay_item
      @purchase_shipping.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end

  private

  def purchase_params
    params.require(:purchase_shipping)
    .permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number)
    .merge(item_id: params[:item_id], user_id: current_user.id, token: params[:token]
    )
  end

  def pay_item
    item_price = @item.price
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: item_price,
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end

  def set_prototype
    @item = Item.find(params[:item_id])
  end
  
  def contributor_confirmation
    redirect_to root_path if current_user == @item.user
  end

  def move_to_root
    redirect_to root_path if @item.purchase.present?
  end

end

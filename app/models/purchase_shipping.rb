class PurchaseShipping
  include ActiveModel::Model
 
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :address, :building, :phone_number, :token
  
  with_options presence: true do
    validates :user_id, :item_id, :city, :address, :token
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "は不正な値です ※ハイフンを含める必要があります"}
    validates :prefecture_id, numericality: {other_than: 1, message: "を選択してください"}
    validates :phone_number, numericality: { only_integer: true, message: "は不正な値です"  }, length: { minimum: 10, maximum: 11, message: "は10文字以上11文字以内で入力してください" }
  end

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Shipping.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, building: building, phone_number: phone_number, purchase_id: purchase.id)
  end
 end
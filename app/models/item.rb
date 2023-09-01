class Item < ApplicationRecord
  belongs_to :user
  #has_one :purchase
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :shipping_fee_responsibility
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :lead_time
  has_one_attached :image

end

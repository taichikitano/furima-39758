class Item < ApplicationRecord
  belongs_to :user
  #has_one :purchase
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :shipping_fee_responsibility
  belongs_to :prefecture
  belongs_to :lead_time

  validates :item_name, :description,  presence: true

  validates :category_id, :status_id, :shipping_fee_responsibility_id, 
            :prefecture_id, :lead_time_id,  
            numericality: { other_than: 1 , message: "can't be blank"
           }

  validates :price, presence: true, format: { with: /\A[0-9]+\z/ }
  validates :price, numericality: {
            greater_than_or_equal_to: 300,
            less_than_or_equal_to: 9_999_999,
            only_integer: true
           }
  
  validates :image, attached: true

end

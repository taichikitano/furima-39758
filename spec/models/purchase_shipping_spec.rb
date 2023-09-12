require 'rails_helper'
RSpec.describe PurchaseShipping, type: :model do

  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @purchase = FactoryBot.build(:purchase_shipping, user_id: user.id, item_id: item.id)
  end

  describe '購入記録の保存' do
    
    context '購入できる場合' do
      it 'すべての値が正しく入力されていれば購入できる' do
        expect(@purchase).to be_valid
      end
      it 'buildingは空でも購入できる' do
        @purchase.building = ''
        expect(@purchase).to be_valid
      end
    end

    context '購入できない場合' do
      it 'postal_codeが空だと購入できない' do
        @purchase.postal_code = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Postal code can't be blank", "Postal code は不正な値です ※ハイフンを含める必要があります")
      end
      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと購入できない' do
        @purchase.postal_code = '1234567'
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Postal code は不正な値です ※ハイフンを含める必要があります")
      end
      it 'prefectureが「---」では購入できない' do
        @purchase.prefecture_id = '1'
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Prefecture を選択してください")
      end
      it 'cityが空だと購入できない' do
        @purchase.city = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("City can't be blank")
      end
      it 'addressが空だと購入できない' do
        @purchase.address = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Address can't be blank")
      end
      it 'phone_numberが空だと購入できない' do
        @purchase.phone_number = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが半角数値でないと購入できない' do
        @purchase.phone_number = 'abcdefghij'
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Phone number は不正な値です")
      end
      it 'phone_numberが10桁未満だと購入できない' do
        @purchase.phone_number = '123456789'
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Phone number は10文字以上11文字以内で入力してください")
      end
      it 'phone_numberが12桁以上だと購入できない' do
        @purchase.phone_number = '123456789012'
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Phone number は10文字以上11文字以内で入力してください")
      end
      it 'tokenが空では購入できない' do
        @purchase.token = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Token can't be blank")
      end
      it 'userが紐付いていないと購入できない' do
        @purchase.user_id = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていないと購入できない' do
        @purchase.item_id = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end


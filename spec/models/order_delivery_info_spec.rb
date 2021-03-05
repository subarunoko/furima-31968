require 'rails_helper'

RSpec.describe OrderDeliveryInfo, type: :model do
  before do
    @order_delivery_info = FactoryBot.build(:order_delivery_info)
  end

  describe "商品購入処理" do
    context "購入処理がうまくいくとき" do
      it "postal_code,token等が存在すれば登録できる" do
        expect(@order_delivery_info).to be_valid
      end

      it "building_nameが空欄でも登録できる" do
        @order_delivery_info.building_name = ""
        expect(@order_delivery_info).to be_valid
      end
    end 
  
  
    context "購入処理がうまくいかないとき" do  
      it "tokenが空では登録できない" do
        @order_delivery_info.token = ""
        @order_delivery_info.valid?
        expect(@order_delivery_info.errors[:token]).to include "を入力してください"
      end

      it "postal_codeが空では登録できない" do
        @order_delivery_info.postal_code = ""
        @order_delivery_info.valid?
        expect(@order_delivery_info.errors[:postal_code]).to include "を入力してください"
      end

      it "postal_codeが半角でないと登録できない" do
        @order_delivery_info.postal_code = "１２３ー４５６７"
        @order_delivery_info.valid?
        expect(@order_delivery_info.errors[:postal_code]).to include "が無効です 半角数字で入力して下さい(※ハイフン含む)"
      end

      it "postal_codeがハイフンを含んでいないと登録できない" do
        @order_delivery_info.postal_code = "1234567"
        @order_delivery_info.valid?
        expect(@order_delivery_info.errors[:postal_code]).to include "が無効です 半角数字で入力して下さい(※ハイフン含む)"
      end

      it "prefectureが選択されていないと登録できない" do
        @order_delivery_info.prefecture_id = 0
        @order_delivery_info.valid?
        expect(@order_delivery_info.errors[:prefecture_id]).to include "が未選択です"
      end

      it "cityが空では登録できない" do
        @order_delivery_info.city = ""
        @order_delivery_info.valid?
        expect(@order_delivery_info.errors[:city]).to include "を入力してください"
      end

      it "house_numberが空では登録できない" do
        @order_delivery_info.house_number = ""
        @order_delivery_info.valid?
        expect(@order_delivery_info.errors[:house_number]).to include "を入力してください"
      end

      it "phone_numberが空では登録できない" do
        @order_delivery_info.phone_number = ""
        @order_delivery_info.valid?
        expect(@order_delivery_info.errors[:phone_number]).to include "を入力してください"
      end

      it "phone_numberが半角でないと登録できない" do
        @order_delivery_info.phone_number = "０９０１２３４５６７８"
        @order_delivery_info.valid?
        expect(@order_delivery_info.errors[:phone_number]).to include "が無効です 半角数字で入力して下さい(※ハイフンなし)"
      end
      
      it "phone_numberが英数字混合だと登録できない" do
        @order_delivery_info.phone_number = "0901234abcd"
        @order_delivery_info.valid?
        expect(@order_delivery_info.errors[:phone_number]).to include "が無効です 半角数字で入力して下さい(※ハイフンなし)"
      end   

      it "phone_numberでハイフンがあると登録できない" do
        @order_delivery_info.phone_number = "090−1234567"
        @order_delivery_info.valid?
        expect(@order_delivery_info.errors[:phone_number]).to include "が無効です 半角数字で入力して下さい(※ハイフンなし)"
      end 

      it "phone_numberが12桁以上だと登録できない" do
        @order_delivery_info.phone_number = "090123456789"
        @order_delivery_info.valid?
        expect(@order_delivery_info.errors[:phone_number]).to include "が無効です 11桁以内で入力して下さい(※ハイフンなし)"
      end
      
    end
  end
end

require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe "商品出品新規登録" do
    context "出品登録がうまくいくとき" do
      it "title等が存在すれば登録できる" do
        expect(@item).to be_valid
      end
    end 
   
    context "出品登録がうまくいかないとき" do  
      it "titleが空では登録できない" do
        @item.title = ""
        @item.valid?
        expect(@item.errors[:title]).to include "を入力してください"
      end
      it "titleが41文字以上では登録できない" do
        'require {"securerandom"}'
        @item.title = SecureRandom.alphanumeric(41)
        @item.valid?
        expect(@item.errors[:title]).to include "の文字数の上限が40文字を超えてます"
      end

      it "descriptionが空では登録できない" do
        @item.description = ""
        @item.valid?
        expect(@item.errors[:description]).to include "を入力してください"
      end
      it "descriptionが1001文字以上では登録できない" do
        @item.description = SecureRandom.alphanumeric(1001)
        @item.valid?
        expect(@item.errors[:description]).to include "の文字数の上限が1000文字を超えてます"
      end

      it "priceが空では登録できない" do
        @item.price = ""
        @item.valid?
        expect(@item.errors[:price]).to include "を入力してください"
      end      
      it "priceが英字では登録できない" do
        @item.price = "abcd"
        @item.valid?
        expect(@item.errors[:price]).to include "が範囲対象外です"
      end
      it "priceが半角英数字では登録できない" do
        @item.price = "123abc"
        @item.valid?
        expect(@item.errors[:price]).to include "が範囲対象外です"
      end
      it "priceが全角では登録できない" do
        @item.price = "１２３４"
        @item.valid?
        expect(@item.errors[:price]).to include "が範囲対象外です"
      end
      it "priceが ¥299 以下では登録できない" do
        @item.price = 299
        @item.valid?
        expect(@item.errors[:price]).to include "が範囲対象外です"
      end
      it "priceが ¥10000000 以上では登録できない" do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors[:price]).to include "が範囲対象外です"
      end

      it "imageが空では登録できない" do
        # @item.image = nil
        @item.images = nil
        @item.valid?
        # expect(@item.errors[:image]).to include "を入力してください"
        expect(@item.errors[:images]).to include "を入力してください"
      end

      it "category_idが未選択では登録できない" do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors[:category_id]).to include "が未選択です"
      end

      it "state_idが未選択では登録できない" do
        @item.state_id = 0
        @item.valid?
        expect(@item.errors[:state_id]).to include "が未選択です"
      end

      it "delivery_fee_idが未選択では登録できない" do
        @item.delivery_fee_id = 0
        @item.valid?
        expect(@item.errors[:delivery_fee_id]).to include "が未選択です"
      end

      it "prefecture_idが未選択では登録できない" do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors[:prefecture_id]).to include "が未選択です"
      end

      it "delivery_days_idが未選択では登録できない" do
        @item.delivery_days_id = 0
        @item.valid?
        expect(@item.errors[:delivery_days_id]).to include "が未選択です"
      end
    end
  end
end

require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe "ユーザー新規登録" do
    context "新規登録がうまくいくとき" do
      it "nicknameとemail, passwordとpassword_confirmation,family_nameとfirst_name,family_name_kanaとfirst_name_kana,birthday が存在すれば登録できる" do
        expect(@user).to be_valid
      end
      it "passwordが 6文字以上かつ半角英数字含む であれば登録できる" do
        @user.password = "a12345"
        @user.password_confirmation = "a12345"
        expect(@user).to be_valid
      end  
    end 
  
  
    context "新規登録がうまくいかないとき" do  
      it "nicknameが空では登録できない" do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors[:nickname]).to include "を入力してください"
      end
      it "emailが空では登録できない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors[:email]).to include "を入力してください"
      end
      it "passwordが空では登録できない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors[:password]).to include "を入力してください"
      end
      it "passwordが5文字以下では登録できない" do
        @user.password = "a1234"
        @user.valid?
        expect(@user.errors[:password]).to include "は6文字以上で入力してください"
      end
      it "passwordが数字のみでは登録できない" do
        @user.password = "123456"
        @user.valid?
        expect(@user.errors[:password]).to include "英字と数字の両方を含めて設定してください"
      end
      it "passwordが英字のみでは登録できない" do
        @user.password = "abcdef"
        @user.valid?
        expect(@user.errors[:password]).to include "英字と数字の両方を含めて設定してください"
      end

      it "password(確認)が空では登録できない" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors[:password_confirmation]).to include "を入力してください"
      end
      it "password(確認)が5文字以下では登録できない" do
        @user.password_confirmation = "a1234"
        @user.valid?
        expect(@user.errors[:password_confirmation]).to include "は6文字以上で入力してください"
      end
      it "password(確認)が数字のみでは登録できない" do
        @user.password_confirmation = "123456"
        @user.valid?
        expect(@user.errors[:password_confirmation]).to include "英字と数字の両方を含めて設定してください"
      end
      it "password(確認)が英字のみでは登録できない" do
        @user.password_confirmation = "abcdef"
        @user.valid?
        expect(@user.errors[:password_confirmation]).to include "英字と数字の両方を含めて設定してください"
      end

      it "苗字が空では登録できない" do
        @user.family_name = ""
        @user.valid?
        expect(@user.errors[:family_name]).to include "を入力してください"
      end
      it "苗字が数字では登録できない" do
        @user.family_name = "123456"
        @user.valid?
        expect(@user.errors[:family_name]).to include "は全角で入力して下さい"
      end

      it "名前が空では登録できない" do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors[:first_name]).to include "を入力してください"
      end
      it "名前が数字では登録できない" do
        @user.first_name = "123456"
        @user.valid?
        expect(@user.errors[:first_name]).to include "は全角で入力して下さい"
      end

      it "苗字(カナ)が空では登録できない" do
        @user.family_name_kana = ""
        @user.valid?
        expect(@user.errors[:family_name_kana]).to include "を入力してください"
      end
      it "苗字(カナ)が漢字では登録できない" do
        @user.family_name_kana = "一二三四五"
        @user.valid?
        expect(@user.errors[:family_name_kana]).to include "は全角カタカナで入力して下さい"
      end
      it "苗字(カナ)がひらがなでは登録できない" do
        @user.family_name_kana = "あいうえお"
        @user.valid?
        expect(@user.errors[:family_name_kana]).to include "は全角カタカナで入力して下さい"
      end

      it "名前(カナ)が空では登録できない" do
        @user.first_name_kana = ""
        @user.valid?
        expect(@user.errors[:first_name_kana]).to include "を入力してください"
      end
      it "名前(カナ)が漢字では登録できない" do
        @user.first_name_kana = "一二三四五"
        @user.valid?
        expect(@user.errors[:first_name_kana]).to include "は全角カタカナで入力して下さい"
      end
      it "名前(カナ)がひらがなでは登録できない" do
        @user.first_name_kana = "あいうえお"
        @user.valid?
        expect(@user.errors[:first_name_kana]).to include "は全角カタカナで入力して下さい"
      end

      it "生年月日が空では登録できない" do
        @user.birthday = ""
        @user.valid?
        expect(@user.errors[:birthday]).to include "を入力してください"
      end

    end
  end
end

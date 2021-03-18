require 'rails_helper'

RSpec.describe "購入品機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @item1 = FactoryBot.create(:item)
    @item2 = FactoryBot.create(:item)
    # @order = FactoryBot.create(:order_delivery_info)    #>>>>>>>> うまく動作しない
    @address = Gimei.address
  end

  context "商品の購入ができる時" do
    it "ログインしたユーザーは商品購入ができる、そして購入済みの商品は買うことができない" do
      #商品1を投稿したユーザーでログインする
      sign_in(@item1.user)
      
      #トップページへ遷移することを確認する
      expect(current_path).to eq root_path

      #「SOLD」の文字がないことを確認する      
      expect(page).to have_no_content("SOLD")

      #すでに投稿済みの内容がフォームに入っていることを確認する（タイトル, 価格）
      expect(page).to have_content("#{@item2.title}")
      expect(page).to have_content("#{@item2.price}")
      expect(page).to have_content("#{@item2.delivery_fee_id}")
 
      #商品詳細ページへ遷移する
      visit item_path(@item2)
      
      #「SOLD」の文字がないことを確認する      
      expect(page).to have_no_content("SOLD")

      #編集,削除のボタンがないことを確認する
      expect(page).to have_no_content("商品の編集")
      expect(page).to have_no_content("削除")
      #購入画面に進むのボタンがあることを確認する
      expect(page).to have_content("購入画面に進む")

      #ログインしたユーザーと出品者が同一でないことを確認
      # expect(current_user).not_to eq @item2.user
      
      click_on "購入画面に進む"

      #商品の購入ページへ遷移することを確認する
      expect(current_path).to eq item_orders_path(@item2)

      #フォームに情報を入力する
      fill_in "card-number", with: "4242424242424242"           #カード番号(テスト用)
      fill_in "card-exp-month", with: "10"                      #month
      fill_in "card-exp-year", with: "23"                       #year
      fill_in "card-cvc", with: "123"                           #CVC(テスト用)

      # fill_in "postal-code", with: @order.postal_code
      fill_in "postal-code", with: "123-4567"
      select "#{@address.prefecture}", from: "order_delivery_info[prefecture_id]"     
      fill_in "city", with: @address.city 
      # fill_in "address", with: @order.house_number
      # fill_in "buliding", with: @order.buliding_name 
      # fill_in "phone-number", with: @order.phone_number  
      fill_in "addresses", with: "1-2-3"
      fill_in "building", with: "〇〇ハイツ"
      fill_in "phone-number", with: "09012345678"

      #購入ボタンをclickするとOrderモデルのカウントが1上がることを確認する             #>>>>>>>> めっちゃ苦労した
      def order_click
        click_on "購入"
        # find('input[name="commit"]').click
        sleep(2)     #待ち時間
      end
      expect{ order_click }.to change{ Order.count }.by(1)


      #購入完了ページへ遷移することを確認する
      expect(current_path).to eq done_item_orders_path(@item2)

      #「購入が完了しました 発送までしばらくお待ち下さい」の文字があることを確認する
      expect(page).to have_content("購入が完了しました\n発送までしばらくお待ち下さい")
      #「トップページへ戻る」の文字があることを確認する
      expect(page).to have_content("トップページへ戻る")

      #トップページへ戻るボタンを押す
      click_on "トップページへ戻る"
      #トップページページへ遷移することを確認する
      expect(current_path).to eq root_path      

      #「SOLD」の文字があることを確認する      
      expect(page).to have_content("SOLD")

      #商品詳細ページへ遷移する
      visit item_path(@item2)
      
      #「SOLD」の文字があることを確認する      
      expect(page).to have_content("SOLD") 

      #編集,削除のボタンがないことを確認する
      expect(page).to have_no_content("商品の編集")
      expect(page).to have_no_content("削除")
      #この商品は売り切れましたのボタンがあることを確認する
      expect(page).to have_content("この商品は売り切れました")
      
      click_on "この商品は売り切れました"

      #商品の購入ページへ遷移しないことを確認する
      expect(current_path).not_to eq item_orders_path(@item2)
    end
  end

  context "商品の購入ができない時" do
    it "ログインしたユーザーは自分の商品は購入ができない" do
      #商品1を投稿したユーザーでログインする
      sign_in(@item1.user)

      #トップページへ遷移することを確認する
      expect(current_path).to eq root_path

      #「SOLD」の文字がないことを確認する      
      expect(page).to have_no_content("SOLD") 

      #商品詳細ページへ遷移する
      visit item_path(@item1)

      #「SOLD」の文字がないことを確認する      
      expect(page).to have_no_content("SOLD")

      #購入画面に進むのボタンがないことを確認する
      expect(page).to have_no_content("購入画面に進む")       
    end

    it "ログインしていないと商品購入画面へ遷移できない" do
      #トップページにいる
      visit root_path

      #「SOLD」の文字がないことを確認する      
      expect(page).to have_no_content("SOLD")  

      #商品詳細ページへ遷移する
      visit item_path(@item1)

      #「SOLD」の文字がないことを確認する      
      expect(page).to have_no_content("SOLD")

      #購入画面に進むのボタンがないことを確認する
      expect(page).to have_no_content("購入画面に進む") 

      #トップページにいる      
      visit root_path
 
      #商品2の詳細ページへ遷移する
      visit item_path(@item2)

      #「SOLD」の文字がないことを確認する      
      expect(page).to have_no_content("SOLD")

      #購入画面に進むのボタンがないことを確認する
      expect(page).to have_no_content("購入画面に進む")
    end
  end

end

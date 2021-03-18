require 'rails_helper'

RSpec.describe "商品出品機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @address = Gimei.address
  end

  context "商品の出品登録ができる時" do
    it "ログインしたユーザーは商品登録ができる" do
      #ログインする
      sign_in(@user)
      
      #出品登録のボタンがあることを確認する
      expect(page).to have_content("出品する")

      # 出品するボタンを押す
      click_on "出品する"      
      #出品登録ページに遷移することを確認する
      expect(current_path).to eq new_item_path
      
      #添付する画像を定義する
      image_path = Rails.root.join('public/images/test_sample1.png')
      # 画像選択フォームに画像を添付する
      attach_file("item[image]", image_path, make_visible: true)

      #フォームに情報を入力する
      fill_in "item-name", with: @item.title
      fill_in "item-info", with: @item.description
      
      #プルダウンから情報を選択する
      select "食品関係", from: "item[category_id]" 
      select "新品・未使用", from: "item[state_id]" 
      select "送料込み(出品者負担)", from: "item[delivery_fee_id]" 
      select @address.prefecture.kanji, from: "item[prefecture_id]" 
      select "1-2日で発送", from: "item[delivery_days_id]"            
      
      #フォームに情報を入力する
      fill_in "item-price", with: @item.price
 
      #出品登録ボタンをclickするとItemモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change {Item.count}.by(1)

      #出品登録完了ページに遷移することを確認する
      expect(current_path).to eq create_done_items_path
      # 「出品登録が完了しました」の文字があることを確認する
      expect(page).to have_content("商品登録が完了しました")
      # 「トップページへ戻る」の文字があることを確認する
      expect(page).to have_content("トップページへ戻る")

      #トップページへ戻るするボタンを押す
      click_on "トップページへ戻る"
      # トップページページへ遷移することを確認する
      expect(current_path).to eq root_path

      #トップページには先ほど投稿した内容の商品画像が存在することを確認する（画像）
      expect(page).to have_selector("img")
      #トップページには先ほど投稿した内容のツイートが存在することを確認する（テキスト）
      expect(page).to have_content(@item.title)
      expect(page).to have_content(@item.price)
      expect(page).to have_content(@item.delivery_fee_id)
    end
  end
  context "商品の出品登録ができない時" do
    it "ログインしていないと商品登録画面へ遷移できない" do
      # トップページに遷移する
      visit root_path

      # 出品するボタンを押す
      click_on "出品する"
      
      # ログインページに遷移することを確認する
      expect(current_path).to eq new_user_session_path
      
      # 出品登録ページへのリンクがない
      expect(page).to have_no_content("出品する")
    end
  end
end


RSpec.describe "商品編集機能", type: :system do
  before do
    @item1 = FactoryBot.create(:item)
    @item2 = FactoryBot.create(:item)
  end
  context "商品の編集ができる時" do
    it "ログインしたユーザーは商品編集ができる" do
      #商品1を投稿したユーザーでログインする
      sign_in(@item1.user)

      #トップページへ遷移することを確認する
      expect(current_path).to eq root_path

      #すでに投稿済みの内容がフォームに入っていることを確認する（タイトル, 価格）
      expect(page).to have_content("#{@item1.title}")
      expect(page).to have_content("#{@item1.price}")
      expect(page).to have_content("#{@item1.delivery_fee_id}")

      #商品詳細ページへ遷移する
      visit item_path(@item1)

      #すでに投稿済みの内容がフォームに入っていることを確認する（タイトル, 説明）
      expect(page).to have_content("#{@item1.title}")
      expect(page).to have_content("#{@item1.price}")
      # expect(page).to have_content("#{@item1.delivery_fee_id}")
      #「商品の編集」のボタンがあることを確認する
      expect(page).to have_content("商品の編集")

      #ログインしたユーザーと出品者が同一であることを確認
      # expect(current_user).to eq @item1.user
      
      click_on "商品の編集"

      #商品の編集ページへ遷移することを確認する
      expect(current_path).to eq edit_item_path(@item1)

      #すでに投稿済みの内容がフォームに入っていることを確認する（タイトル, 説明）
      expect(page).to have_content("#{@item1.title}")
      expect(page).to have_content("#{@item1.description}")
      
      #投稿内容を編集する
      # binding.pry      
      fill_in "item-name", with: "#{@item1.title}編集したタイトル"
      fill_in "item-price", with: "123456"      
      
      #編集ボタンをclickしても商品モデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Item.count }.by(0)

      #編集完了画面に遷移したことを確認する
      expect(current_path).to eq update_done_item_path(@item1)
      #「編集が完了しました」の文字があることを確認する
      expect(page).to have_content("商品の編集が完了しました")
      #「トップページへ戻る」の文字があることを確認する
      expect(page).to have_content("トップページへ戻る")

      #トップページへ戻るボタンを押す
      click_on "トップページへ戻る"
      #トップページページへ遷移することを確認する
      expect(current_path).to eq root_path

      #トップページには先ほど変更した内容の情報が存在することを確認する（タイトル, 価格）
      expect(page).to have_content("#{@item1.title}編集したタイトル")
      expect(page).to have_content("123456")
    end
  end
  context "商品編集ができない時" do 
    it 'ログインしたユーザーは自分以外が投稿した商品編集画面には遷移できない' do
      #商品1を投稿したユーザーでログインする
      sign_in(@item1.user)

      #トップページへ遷移することを確認する
      expect(current_path).to eq root_path

      #商品2の詳細ページへ遷移する
      visit item_path(@item2)

      #ログインしたユーザーと出品者が同一ではないことを確認
      # expect(current_user).not_to eq @item1.user

      #「商品の編集」のボタンがないことを確認する
      expect(page).to have_no_content("商品の編集")
    end

    it "ログインしていないと商品編集画面へ遷移できない" do
      #トップページにいる
      visit root_path
 
      #商品1の詳細ページへ遷移する
      visit item_path(@item1)

      #「商品の編集」のボタンがないことを確認する
      expect(page).to have_no_content("商品の編集")   

      #トップページにいる      
      visit root_path
 
      #商品2の詳細ページへ遷移する
      visit item_path(@item2)

      #編集ボタンがないことを確認する
      expect(page).to have_no_content("商品の編集")
    end
  end
end


RSpec.describe "商品削除機能", type: :system do
  before do
    @item1 = FactoryBot.create(:item)
    @item2 = FactoryBot.create(:item)
  end
  context "商品の削除ができる時" do
    it "ログインしたユーザーは商品削除ができる" do
      #商品1を投稿したユーザーでログインする
      sign_in(@item1.user)

      #トップページへ遷移することを確認する
      expect(current_path).to eq root_path

      #すでに投稿済みの内容がフォームに入っていることを確認する（タイトル, 価格）
      expect(page).to have_content("#{@item1.title}")
      expect(page).to have_content("#{@item1.price}")
      expect(page).to have_content("#{@item1.delivery_fee_id}")

      #商品詳細ページへ遷移する
      visit item_path(@item1)
      #すでに投稿済みの内容がフォームに入っていることを確認する（タイトル, 説明）
      expect(page).to have_content("#{@item1.title}")
      expect(page).to have_content("#{@item1.price}")
      # expect(page).to have_content("#{@item1.delivery_fee_id}") 

      #「削除」のボタンがあることを確認する
      expect(page).to have_content("削除")
      
      #ログインしたユーザーと出品者が同一であることを確認
      # expect(current_user).to eq @item1.user
      
      click_on "削除"

      #商品の削除ページへ遷移することを確認する
      expect(current_path).to eq destroy_caution_item_path(@item1)
      #「以下の商品を削除します。本当によろしいですか？」の文字があることを確認する      
      expect(page).to have_content("以下の商品を削除します。\n本当によろしいですか？")
      #「削除」「商品詳細ページへ戻る」のボタンがあることを確認する
      expect(page).to have_content("削除")
      expect(page).to have_content("商品詳細ページへ戻る")      
      
      #削除ボタンをclickするとItemモデルのカウントが1下がることを確認する
      expect{
        find('a[name="commit_del"]').click
      }.to change {Item.count}.by(-1)

      #商品の削除完了ページへ遷移することを確認する
      expect(current_path).to eq destroy_done_item_path(@item1)
      #「商品の削除が完了しました」の文字があることを確認する      
      expect(page).to have_content("商品の削除が完了しました")
      #「トップページへ戻る」の文字があることを確認する
      expect(page).to have_content("トップページへ戻る")

      click_on "トップページへ戻る"

      #トップページへ遷移することを確認する
      expect(current_path).to eq root_path

      #トップページにはツイート1の内容が存在しないことを確認する（画像）
      expect(page).to have_no_selector ".content_post[style='background-image: url(#{@item1.image});']"
      ## トップページにはツイート1の内容が存在しないことを確認する（タイトル, 価格）
      expect(page).to have_no_content("#{@item1.image}")
    end
  end
  context "商品の削除ができない時" do
    it "ログインしたユーザーは自分以外が投稿した商品削除画面には遷移できない" do
      #商品1を投稿したユーザーでログインする
      sign_in(@item1.user)
  
      #トップページへ遷移することを確認する
      expect(current_path).to eq root_path

      #商品2の詳細ページへ遷移する
      visit item_path(@item2)

      #ログインしたユーザーと出品者が同一ではないことを確認
      # expect(current_user).not_to eq @item1.user

      #「削除」のボタンがないことを確認する
      expect(page).to have_no_content("削除")      
    
    
    end
    
    it "ログインしていないと商品削除画面へ遷移できない" do
      #トップページに移動する
      visit root_path

      #商品1の詳細ページへ遷移する
      visit item_path(@item1)

      #「削除」のボタンがないことを確認する
      expect(page).to have_no_content("削除")
      
      #トップページに移動する
      visit root_path

      #商品2の詳細ページへ遷移する
      visit item_path(@item2)

      #「削除」のボタンがないことを確認する
      expect(page).to have_no_content("削除")
    end
  end
end

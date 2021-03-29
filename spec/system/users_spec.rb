require 'rails_helper'

RSpec.describe "ユーザー新規登録", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
    
  context "ユーザー新規登録ができる時" do
    it "正しい情報を入力すればユーザー新規登録ができてトップページに移動する"  do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content("新規登録")
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in "nickname", with: @user.nickname
      fill_in "email", with: @user.email
      fill_in "password", with: @user.password
      fill_in "password-confirmation", with: @user.password_confirmation
      fill_in "last-name", with: @user.family_name
      fill_in "first-name", with: @user.first_name
      fill_in "last-name-kana", with: @user.family_name_kana
      fill_in "first-name-kana", with: @user.first_name_kana
      select @user.birthday.year, from: "user[birthday(1i)]" 
      select @user.birthday.month, from: "user[birthday(2i)]"  
      select @user.birthday.day, from: "user[birthday(3i)]" 
            
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change {User.count}.by(1)
            
      # トップページへ遷移する
      expect(current_path).to eq root_path
      # # カーソルを合わせるとログアウトボタンが表示されることを確認する
      # expect(
      #   find(".user_nav").find("span").hover
      # ).to have_content('ログアウト')
      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content("新規登録")
      expect(page).to have_no_content("ログイン")  
    end
  end
  context "ユーザー新規登録ができない時" do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content("新規登録")
      # 新規登録ページへ移動する
      click_on "新規登録" 
      # visit new_user_registration_path

      # ユーザー情報を入力する
      fill_in "nickname", with: ""
      fill_in "email", with: ""
      fill_in "password", with: ""
      fill_in "password-confirmation", with: ""
      fill_in "last-name", with: ""
      fill_in "first-name", with: ""
      fill_in "last-name-kana", with: ""
      fill_in "first-name-kana", with: ""
      sleep(2)     #待ち時間
      select "--", from: "user[birthday(1i)]" 
      select "--", from: "user[birthday(2i)]"  
      select "--", from: "user[birthday(3i)]" 

      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change {User.count}.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq "/users"
    end
  end
end


# 以下、ログイン／ログアウトのテストコード
RSpec.describe "ログイン", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context "ログインできる時" do
    it "保存されているユーザーの情報と合致すればログインできる" do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content("ログイン")
      # ログインページへ遷移する
      click_on "ログイン" 
      # visit new_user_session_path

      # 正しいユーザー情報を入力する
      fill_in "email", with: @user.email
      fill_in "password", with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq root_path
      # カーソルを合わせるとログアウトボタンが表示されることを確認する
      # expect(
      #   find(".user_nav").find("span").hover
      # ).to have_content("ログアウト")
      # サインアップページへ遷移するボタンやログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content("新規登録")
      expect(page).to have_no_content("ログイン")
    end
  end

  context "ログインできない時" do
    it "保存されているユーザーの情報と合致しないとログインできない" do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content("ログイン")
      # ログインページへ遷移する
      click_on "ログイン" 
      # visit new_user_session_path

      # ユーザー情報を入力する
      fill_in "email", with: ""
      fill_in "password", with: ""
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻されることを確認する
      expect(current_path).to eq new_user_session_path
    end
  end  
end
  






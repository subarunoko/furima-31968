class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # devise :validatable, password_length: 6..16     #password 6文字以上16文字以下
  
  with_options presence: true do
    validates :nickname
    validates :family_name, format: {with: /\A[ぁ-んァ-ン一-龥]/, message: "は全角で入力して下さい"}
    validates :first_name, format: {with: /\A[ぁ-んァ-ン一-龥]/, message: "は全角で入力して下さい"}
    validates :family_name_kana, format: {with: /\A[ァ-ヶー－]+\z/, message: "は全角カタカナで入力して下さい"}
    validates :first_name_kana, format: {with: /\A[ァ-ヶー－]+\z/, message: "は全角カタカナで入力して下さい"}
    validates :birthday
    validates :password,format:{with: /(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{6,}/, message: "英字と数字の両方を含めて設定してください" }
  end

  has_many :items
  has_one :order  #has_many?? has_one??

end

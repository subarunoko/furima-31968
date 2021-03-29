class Item < ApplicationRecord

  with_options presence: true do
    validates :title, length: { maximum: 40, message: "の文字数の上限が40文字を超えてます" }
    validates :description , length: { maximum: 1000, message: "の文字数の上限が1000文字を超えてます"  }
    validates :price, format: {with: /\A[0-9]+\z/, message: "は半角数字で入力して下さい"}
    # validates :image
    validates :images # ※画像複数枚投稿
  end

  with_options numericality: { other_than: 0, message: "が未選択です"} do |i|
    i.validates :category_id
    i.validates :state_id
    i.validates :delivery_fee_id
    i.validates :prefecture_id
    i.validates :delivery_days_id
  end
  
  validates :price, numericality: { only_integer: true, greater_than: 299, less_than: 9999999, message: "が範囲対象外です"}


  # has_one_attached :image  #<<<<<< imagemagik対応(※画像１枚)
  has_many_attached :images  #<<<<<< imagemagik対応(※画像複数枚投稿)
  belongs_to :user
  has_one :order

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :state
  belongs_to :delivery_fee 
  belongs_to :prefecture
  belongs_to :delivery_days


  def self.search(search)
    if search != ""
      Item.where('title LIKE(?)', "%#{search}%")
    else
      Item.all
    end
  end

  def previous
    Item.where("id > ?", id).order("id ASC").first
  end

  def next
    Item.where("id < ?", id).order("id DESC").first
  end  

end

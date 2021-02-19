class Item < ApplicationRecord

  with_options presence: true do
    validates :title, length: { maximum: 40, message: "の文字数の上限が40文字を超えてます" }
    validates :description , length: { maximum: 1000, message: "の文字数の上限が1000文字を超えてます"  }
    validates :price, format: {with: /\A[0-9]+\z/, message: "は半角数字で入力して下さい"}
    validates :image, unless: :was_attached?
  end

  validates :category_id, numericality: { other_than: 0, message: "が未選択です"}
  validates :state_id, numericality: { other_than: 0, message: "が未選択です"}
  validates :delivery_fee_id, numericality: { other_than: 0, message: "が未選択です"}
  validates :delivery_area_id, numericality: { other_than: 0, message: "が未選択です"}
  validates :delivery_days_id, numericality: { other_than: 0, message: "が未選択です"}
  validates :price, numericality: { only_integer: true, greater_than: 300, less_than: 9999999, message: "が範囲対象外です"}

  def was_attached?
    self.image.attached?
  end


  extend ActiveHash::Associations::ActiveRecordExtensions
  has_one_attached :image  #<<<<<< imagemagik対応
  belongs_to :user
  belongs_to :category
  belongs_to :state
  belongs_to :deliveryfee 
  belongs_to :prefecture
  belongs_to :deliveryday

end

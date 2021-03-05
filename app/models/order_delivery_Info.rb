class OrderDeliveryInfo
  
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number, :user_id, :item_id, :token
  

  with_options presence: true do
    validates :token   
    
    # 「住所」の郵便番号に関するバリデーション 
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "が無効です 半角数字で入力して下さい(※ハイフン含む)" }
    validates :city
    validates :house_number
    validates :phone_number, numericality: { only_integer: true, message: "が無効です 半角数字で入力して下さい(※ハイフンなし)" }
    validates :phone_number, length: { maximum: 11,  message: "が無効です 11桁以内で入力して下さい(※ハイフンなし)" }

  end

  # 「住所」の都道府県に関するバリデーション
  validates :prefecture_id, numericality: { other_than: 0, message: "が未選択です" }



  def save
    # 購入品購入者情報の保存 ※覚書きのため削除しません
    order = Order.create(user_id: user_id, item_id: item_id)
    #配送先情報の保存 ※覚書きのため削除しません
    DeliveryInfo.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, house_number: house_number, building_name: building_name, phone_number: phone_number, order_id: order.id)

  end

end
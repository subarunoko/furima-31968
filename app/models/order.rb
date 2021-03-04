class Order < ApplicationRecord

  belongs_to :user
  belongs_to :item
  has_one :delivery_info

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture

end

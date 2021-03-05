FactoryBot.define do
  factory :order_delivery_info do
    token                       {"tok_abcdefghijk00000000000000000"}
    postal_code                 {'123-4567'}
    prefecture_id               {16}
    city                        {'砺波市'}
    house_number                {'1−2−3'}
    building_name               {'〇〇ハイツ'}
    phone_number                {'09012345678'}
  end
end

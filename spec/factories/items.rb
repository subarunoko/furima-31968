FactoryBot.define do
  factory :item do
    association :user

    random = Random.new
    # rnd_price = Random.rand(300..9999999)
    rnd_price = Random.rand(300..500)
    rnd_category = random.rand(1..10)
    rnd_state = random.rand(1..6)
    rnd_delivery_fee = random.rand(1..2)
    rnd_prefecture = random.rand(1..47)
    rnd_delivery_days = random.rand(1..3)
    rnd_title = Faker::Lorem.sentence
    rnd_description = Faker::Lorem.sentence


    # title                 {"sample1"}
    # description           {"text"}
    title                 {rnd_title}    
    description           {rnd_description}
    price                 {rnd_price}
    category_id           {rnd_category}
    state_id              {rnd_state}
    delivery_fee_id       {rnd_delivery_fee}
    prefecture_id         {rnd_prefecture}
    delivery_days_id      {rnd_delivery_days}

    after(:build) do |item|
      # item.image.attach(io: File.open("public/images/test_sample1.png"), filename: "test_image.png")
      item.images.attach(io: File.open("public/images/test_sample1.png"), filename: "test_image.png")
    end
  end
end

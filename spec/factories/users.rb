FactoryBot.define do
  factory :user do
    nickname                {Faker::Name.initials(number: 2)}
    email                   {Faker::Internet.free_email}
    # password                {Faker::Internet.password(min_length: 6)}
    password                {"123abc"}
    password_confirmation   {password}

    transient do
      person {Gimei.name}
    end
  
    family_name             {person.last.kanji}
    first_name              {person.first.kanji}
    family_name_kana        {person.last.katakana}
    first_name_kana         {person.first.katakana}
    # birthday                {"2000-01-01"}

    'require {"date"}'
    s1 = Date.parse("1920/12/31")
    s2 = Date.parse("2020/12/31")
    birth_day = Random.rand(s1..s2)
    birthday                {birth_day}
  end
end

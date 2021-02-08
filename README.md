## テーブル設計

## users テーブル

| Column              | Type      | Options     |
| --------------------| --------- | ----------- |
| nickname            | string    | null: false |
| email               | string    | null: false |
| password            | string    | null: false |
| family_name         | string    | null: false |
| first_name          | string    | null: false |
| family_name_kana    | string    | null: false |
| first_name_kana     | string    | null: false |
| birth_year          | integer   | null: false |
| birth_month         | integer   | null: false |
| birth_day           | integer   | null: false |

### Association
- has_many :items
- has_many :purchases



## items テーブル

| Column           | Type         | Options                        |
| ---------------- | ------       | -----------                    |
| title            | string       | null: false                    |
| description      | text         | null: false                    |
| price            | integer      | null: false                    |
| category         | string       | null: false                    |
| state            | string       | null: false                    |
| delivery_fee     | string       | null: false                    |
| delivery_area    | string       | null: false                    |
| delivery_days    | string       | null: false                    |
| image            | activestrage | null: false                    |
| user_id          | references   | null: false, foreign_key: true |
| purchase_id      | references   | null: false, foreign_key: true |

## Association
- belongs_to :user
- belongs_to :purchase



## purchases テーブル

| Column           | Type         | Options                        |
| ---------------- | ------       | -----------                    |
| card_info        | string       | null: false                    |
| card_year        | text         | null: false                    |
| card_month       | integer      | null: false                    |
| card_code        | string       | null: false                    |
| user_id          | references   | null: false, foreign_key: true |

## Association
- belongs_to :user
- has_many :items  
- has_one :delivery_info



## delivery_info テーブル

| Column           | Type         | Options                        |
| ---------------- | ------       | -----------                    |
| postal_code      | string       | null: false                    |
| prefectures      | string       | null: false                    |
| address          | string       | null: false                    |
| building_name    | string       | null: false                    |
| phone_number     | integer      | null: false                    |
| purchase_id      | references   | null: false, foreign_key: true |

## Association
- belongs_to :purchase

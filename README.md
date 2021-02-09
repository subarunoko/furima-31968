## テーブル設計

## users テーブル

| Column              | Type      | Options                   |
| --------------------| --------- | ------------------------- |
| nickname            | string    | null: false               |
| email               | string    | null: false, unique: true |
| encrypted_password  | string    | null: false               |
| family_name         | string    | null: false               |
| first_name          | string    | null: false               |
| family_name_kana    | string    | null: false               |
| first_name_kana     | string    | null: false               |
| birthday            | date      | null: false               |

### Association
- has_many :items
- has_many :purchases



## items テーブル

| Column           | Type         | Options                        |
| ---------------- | ------       | -----------                    |
| title            | string       | null: false                    |
| description      | text         | null: false                    |
| price            | integer      | null: false                    |
| category_id      | integer      | null: false                    |
| state_id         | integer      | null: false                    |
| delivery_fee_id  | integer      | null: false                    |
| delivery_area_id | integer      | null: false                    |
| delivery_days_id | integer      | null: false                    |
| user             | references   | null: false, foreign_key: true |

## Association
- belongs_to :user
- has_one :purchase



## purchases テーブル

| Column           | Type         | Options                        |
| ---------------- | ------       | -----------                    |
| user             | references   | null: false, foreign_key: true |

## Association
- belongs_to :user
- belongs_to :item  
- has_one :delivery_info



## delivery_info テーブル

| Column           | Type         | Options                        |
| ---------------- | ------       | -----------                    |
| postal_code      | string       | null: false                    |
| prefectures_id   | integer      | null: false                    |
| city             | string       | null: false                    |
| address          | string       | null: false                    |
| building_name    | string       |                                |
| phone_number     | string       | null: false                    |


## Association
- belongs_to :purchase

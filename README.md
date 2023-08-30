# README

# テーブル設計

## users テーブル
| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| first_name         | string  | null: false               |
| last_name          | string  | null: false               |
| first_name_kana    | string  | null: false               |
| last_name_kana     | string  | null: false               |
| birth_year_id      | integer | null: false               |
| birth_month_id     | integer | null: false               |
| birth_day_id       | integer | null: false               |
### Association
- has_many :items
- has_many :purchases
- belongs_to_active_hash :birth_year
- belongs_to_active_hash :birth_month
- belongs_to_active_hash :birth_day

## items テーブル
| Column                         | Type      | Options                        | 
| ------------------------------ | --------- | ------------------------------ |
| item_name                      | string    | null: false                    |
| description                    | text      | null: false                    |
| category_id                    | integer   | null: false                    |
| status_id                      | integer   | null: false                    |
| shipping_fee_responsibility_id | integer   | null: false                    |
| prefecture_id                  | integer   | null: false                    |
| lead_time_id                   | integer   | null: false                    |
| price                          | integer   | null: false                    |
| user                           | references| null: false, foreign_key: true |
### Association
- belongs_to :user
- has_one :purchase
- belongs_to_active_hash :category
- belongs_to_active_hash :status
- belongs_to_active_hash :shipping_fee_responsibility
- belongs_to_active_hash :prefecture
- belongs_to_active_hash :lead_time

## purchases テーブル
| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |
### Association
- belongs_to :user
- belongs_to :item
- has_one :shipping

## shippings テーブル
| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| postal_code   | string     | null: false                    |
| prefecture-id | string     | null: false                    |
| city          | string     | null: false                    |
| address       | string     | null: false                    |
| building      | string     |                                |
| phone_number  | string     | null: false                    |
| purchase      | references | null: false, foreign_key: true |
### Association
- belongs_to :purchase
- belongs_to_active_hash :prefecture

# README

# テーブル設計

## users テーブル
| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| name               | string | null: false               |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
### Association
- has_many :items
- has_many :purchases

## items テーブル
| Column                      | Type      | Options                        | 
| --------------------------- | --------- | ------------------------------ |
| item_name                   | string    | null: false                    |
| description                 | text      | null: false                    |
| category                    | string    | null: false                    |
| status                      | string    | null: false                    |
| shipping_fee_responsibility | string    | null: false                    |
| shipping_origin             | string    | null: false                    |
| lead_time                   | integer   | null: false                    |
| price                       | integer   | null: false                    |
| user                        | references| null: false, foreign_key: true |
### Association
- belongs_to :user
- has_one :purchase

## purchases テーブル
| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |
### Association
- belongs_to :user
- belongs_to :item
- has_pne :shippings

## shippings テーブル
| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| postal_code  | integer    | null: false                    |
| prefecture   | string     | null: false                    |
| city         | string     | null: false                    |
| address      | string     | null: false                    |
| building     | string     |                                |
| phone_number | integer    | null: false                    |
| purchase     | references | null: false, foreign_key: true |
### Association
- belongs_to :purchase

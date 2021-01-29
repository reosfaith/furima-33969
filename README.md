# テーブル設計

## users テーブル

| Column             | Type    | Options     |
| ------------------ | ------- | ----------- |
| nickname           | string  | null: false |
| email              | string  | null: false |
| encrypted_password | string  | null: false |
| family_name        | string  | null: false |
| first_name         | string  | null: false |
| family_name_kana   | string  | null: false |
| first_name_kana    | string  | null: false |
| birthday           | integer | null: false |

### Association

- has_many :items
- has_many :orders
- has_many :destinations

## items テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| user               | references | null: false, foreign_key: true |
| product_name       | string     | null: false                    |
| image              |            | null: false                    |
| price              | integer    | null: false                    |
| description        | text       | null: false                    |
| category_id        | string     | null: false                    |
| condition_id       | string     | null: false                    |
| shipping_cost_id   | integer    | null: false                    |
| shipping_area_id   | string     | null: false                    |
| shipping_date_id   | integer    | null: false                    |

### Association

- belongs_to :user
- belongs_to :order

## orders テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- has_many :users
- has_many :items

## destinations テーブル

| Column        | Type    | Options     |
| ------------- | ------- | ----------- |
| post_code     | integer | null: false |
| prefecture_id | string  | null: false |
| city          | string  | null: false |
| house_number  | string  | null: false |
| building_name | string  | null: false |

### Association

- belongs_to :user
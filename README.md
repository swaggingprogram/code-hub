# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |


### Association

- has_many :codes
- has_many :comments

## codes テーブル
  
| Column           | Type       | Options                       |
| ------           | ------     | -----------                   |
| title            | string     | null: false                   |
| code             | text       | null: false                   |
| category_id      | integer    | null: false                   |
| genre   _id      | integer    | null: false                   |
| user             | references | null: false foreign_key: true |

### Association

- belongs_to :user
- has_many :comments

## comments テーブル

| Column       | Type       | Options                        |
| -------      | ---------- | ------------------------------ |
| concept      | text       |                                |
| code         | references | null: false, foreign_key: true |
| user         | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :code
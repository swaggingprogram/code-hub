# アプリケーション名
Code Hub

# アプリケーション概要
プログラミングのテクニックやメソッドの使い方をシェアできるwebアプリケーション。

# URL

# テスト用アカウント

# 利用方法
1. トップページ上部からユーザー新規登録を行う
2. 新規投稿ボタンから、コード、カテゴリー、ジャンルを入力し、投稿する。
3. 一覧ページから投稿されたコードをクリックし、コードの詳細や解説を読むことができる。
4. コードの詳細ではコメントを書き込むことができ、コードやメソッドについて議論を交わすことができる。

# アプリケーションを作成した背景
プログラミングスクールで学習している時、理解しにくいメソッドや技法について調べることが多々あった。その中で、ネットに転がっている情報の雑多さに、不便さを感じた。
そこでもっとシンプルにコードやメソッドの情報を集められるサイトは需要があると推察し、SNS型のプログラミング学習サイトを開発することとした。

# 洗い出した要件
https://docs.google.com/spreadsheets/d/14jEp8c0W7AWzwO3IfJczgBzo2wmJBSZMSx6OQl5Ks2A/edit?usp=sharing

# 実装した機能の紹介画像及びGIF
・シンタックスハイライトの実装
[![Image from Gyazo](https://i.gyazo.com/93a658cb1948e963886dc1da2fc8d4f2.png)](https://gyazo.com/93a658cb1948e963886dc1da2fc8d4f2)

・新規投稿およびコメントフォームにマークダウンを実装
[![Image from Gyazo](https://i.gyazo.com/a353581a9faf0b540a33e84879d19abd.png)](https://gyazo.com/a353581a9faf0b540a33e84879d19abd)

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
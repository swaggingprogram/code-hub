# アプリケーション名
Code Hub

# アプリケーション概要
プログラミングを学習中に、学習した内容をまとめる方法はノートにまとめる or メモアプリにまとめるという選択肢があった。私は前者を選択していたが、インテンドが分かりにくかったり、コピーできないなどの煩わしさがあり、自分のインプットをまとめる媒体があればいいなと考えていた。
これらを解決したく、今回のアプリ開発に至った。

## 注意点
このアプリはMacbookProも用いて作成されたため,windowsなどの
モニターサイズが大きいPCで使用すると一部ビューが崩れる可能性があります。<br>また、レスポンシブデザインに対応していないため、ブラウザを最大サイズにして見ることをおすすめします。

# URL
https://code-hub37103.herokuapp.com/

# basic認証
ID: admin <br>Pass: 1111

# テスト用アカウント
・認証アカウント1(tester1)
  メアド : abcd@gmail.com
  pass  : q12345<br>
・認証アカウント2(tester2)
  メアド : wasd@gmail.com
  pass  : qwer123

# 利用方法
・コード投稿機能
ログイン後、画面右下のリンクからコードの新規投稿が可能である。
当アプリはマークダウン記法に対応しているため、投稿する言語を指定し、テキストエディタのようにコードを記述することができる。<br>投稿するコードは記事タイトル、カテゴリーとジャンルを指定できる。投稿されたコードは一覧画面にて表示されるようになる。<br>
・コード閲覧機能
一覧に表示されているリンクからコードの詳細を表示することができる。詳細画面では、コードのコピーボタンが搭載されており、ボタンを押すだけでコードをコピーすることが可能。また、投稿者のみ、コードの編集・削除が可能になる。<br>
・コメント機能
コードの詳細画面にて、コードに対する感想などをコメントできる。<br>また、コメントもマークダウン記法に対応しているため、コードに対する意見や改善案などをマークダウンで投稿することができる。

・その他便利機能
1. シンタックスハイライト
投稿されたコードはシンタックスハイライトによってdivやdefのようなメソッドの開始時点やクラスの区切りを、視覚的に捉えることができる。
2. 閲覧履歴の表示
一覧画面右上にて、サイト上で見られたコードの履歴を確認することができる。表示されたタイトルがリンクになっており、詳細画面へ遷移することができる。
3. ランダム表示
一覧画面にて、サイト上で公開されているコードが読み込みごとにランダムで一つ表示されるようになる。

# 洗い出した要件
| 機能           | 目的      | 詳細     | ストーリー             |
| ---           | ----      | ---     | --------             |
| ユーザー管理機能 | 登録されたユーザーのみ使用可能にする | 名前、email、パスワードを登録させる | 新規登録後に、自己紹介を編集できるようにする |
| コード投稿機能  | コードを投稿できるようにする        | 投稿する際には、タイトル、コード、カテゴリ、ジャンルの記入が必須にする            | マークダウン記法に対応させ、テキストエディタにコードを書いている感覚に近いようにする |
| 一覧・詳細表示機能 | 投稿されたコードを表示できるようにする | 一覧画面ではコードの内容とタイトルの表示。詳細画面ではコードの全体や各設定ボタンが表示されるようにする | マークダウンで書かれたコードはシンタックスハイライトで装飾されるようにし、見やすくする。|
| コメント機能     | 投稿されたコードに対して、コメントを打てるようにする | コメントでもマークダウンを使えるようにする    |            |

# 実装した機能の紹介画像及びGIF
・シンタックスハイライトの実装
[![Image from Gyazo](https://i.gyazo.com/93a658cb1948e963886dc1da2fc8d4f2.png)](https://gyazo.com/93a658cb1948e963886dc1da2fc8d4f2)

・新規投稿およびコメントフォームにマークダウンを実装
[![Image from Gyazo](https://i.gyazo.com/a353581a9faf0b540a33e84879d19abd.png)](https://gyazo.com/a353581a9faf0b540a33e84879d19abd)

・リアルタイププレビューを実装
[![Image from Gyazo](https://i.gyazo.com/3e16ae5f1d1b376efee90f4cf7e4c763.gif)](https://gyazo.com/3e16ae5f1d1b376efee90f4cf7e4c763)

・コメント画面でのシンタックスハイライトの実装
[![Image from Gyazo](https://i.gyazo.com/076b8246d08f9a8fef502d895508e54d.png)](https://gyazo.com/076b8246d08f9a8fef502d895508e54d)

・キーワード&カテゴリーでの検索機能の実装
[![Image from Gyazo](https://i.gyazo.com/bec25f46840815742209604607bb4807.gif)](https://gyazo.com/bec25f46840815742209604607bb4807)

・閲覧履歴&コードのランダム表示
[![Image from Gyazo](https://i.gyazo.com/10dfd3493fe40e208b342b644e0be9ae.gif)](https://gyazo.com/10dfd3493fe40e208b342b644e0be9ae)

# 工夫した部分
・マークダウン記法&シンタックスハイライトを実装することで、web上で使える第二のテキストエディタのようにしたこと<br>
・閲覧履歴やランダム表示さらにクリップボード機能を実装することで、動的なアプリとして使えるようにした<br>
・コメント画面でもマークダウンを使えるようにしたことで、コードでの意見交換をしやすくしたこと

# 現在検討中の追加機能
・コードのリファクタリング<br>
・ビューの改修<br>
・javascriptによるアニメーションの追加

# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |
| introduction       | text   |             |


### Association

- has_many :codes
- has_many :comments
- has_many :histories

## codes テーブル
  
| Column           | Type       | Options                       |
| ------           | ------     | -----------                   |
| title            | string     | null: false                   |
| codetext         | text       | null: false                   |
| category_id      | integer    | null: false                   |
| genre_id         | integer    | null: false                   |
| user             | references | null: false foreign_key: true |

### Association

- belongs_to :user
- belongs_to :category
- belongs_to :genre
- has_many :comments
- has_many :histories

## comments テーブル

| Column       | Type       | Options                        |
| -------      | ---------- | ------------------------------ |
| concept      | text       |                                |
| code         | references | null: false, foreign_key: true |
| user         | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :code

## histories テーブル

| Column       | Type       | Options                        |
| -------      | ---------- | ------------------------------ |
| code         | references | null: false, foreign_key: true |
| user         | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :code

# ローカルでの動作方法
```ターミナル
% git clone https://github.com/swaggingprogram/code-hub.git
% cd code-hub
% bundle install
% rails db:create
% rails db:migrate
$ rails s
 → http://localhost:3000
```

# 開発環境
フロントエンド：HTML5/CSS/JavaScript<br>
バックエンド：Ruby on Rails(6.0.0)/Ruby(2.6.5)/JavaScript<br>
テスト：RSpec<br>
Linter：Rubocop<br>
データベース：MySQL/Sequel Pro<br>
インフラ：Heroku<br>
タスク管理：GitHub
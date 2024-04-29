# アプリケーション名
### Calen-Diary（カレンダイアリー）


# アプリケーション概要
### グループでカレンダー × 小さなSNS
* 家族や友人、恋人等小さなグループでカレンダーを共有できる
* グループ内で日記やつぶやきを共有、連絡を取り合ったり感情を共有したりできる
* 気心の知れた人と、グループ内限定のクローズドなSNSを楽しむことができる


# URL
https://original-app-1.onrender.com


# テスト用アカウント
* Basic認証ID : yuki
* Basic認証パスワード : 9969
* ログインID : manemane3@gmail.com
* ログインパスワード : manemane3


# 利用方法
* ユーザー新規登録を行う。
* カレンダーを共有したい友人を選び、ルーム（グループカレンダー）を作成する。
* ルーム（グループカレンダー）内でポストを投稿する。ポストは予定、日記、タスクの中から選ぶことができる。


# アプリケーションを作成した背景
### グループ共有カレンダー内に、日記の投稿等のSNS機能を付与することで、気軽なコミュニケーションを実現する。
以下のようなユーザー向けに作成。
* 家族や友人、恋人等でグループカレンダーを作成し、予定を共有したいユーザー
* 小さなグループで、日記やつぶやきを共有しクローズドなSNSを楽しみたいユーザー（既存のオープンなSNSに疲れたユーザー）
* LINE等のチャットグループでは連絡しづらい（喫緊の連絡予定がない）が、グループで気軽なコミュニケーションを楽しみたいユーザー


# 実装予定の機能
* 個人カレンダーを作り、そこに自分の参加するグループの予定全て表示できるようにする
* カレンダーの月表示、週表示の切り替え機能追加
* コメント機能追加
* いいね機能追加


# データベース設計
![alt text](<スクリーンショット 2024-04-11 17.01.03.png>)

# 画面遷移図
![alt text](<スクリーンショット 2024-04-11 17.03.09.png>)

# 開発環境
* Ruby on Rails
* HTML, CSS
* MySQL, postgreSQL
* Render
* GitHub
* テキストエディタ（VS Code）


# 工夫したポイント
* Ruby on RailsのGem「Simple Calender」を使い、見やすいカレンダーを実装。
* 新規ルーム（グループ）作成時は、複数の友人をグループに参加させられるようにしたいので、複数選択機能を実装。
* 新規ポスト投稿時は、投稿内容の種別を明確にするため、プルダウンで「予定」「日記」「タスク」の中から選択可能にした。Active Hushを用いて実装。


# 改善点
* 現状、参加ルーム（グループ）ごとのバラバラのカレンダーしか表示できない。ログインしているユーザーの全ての予定が反映されるカレンダーを作り、そこに自分の参加するグループの予定全て表示できるようにすると、より使いやすいと感じる。


# テーブル設計

### users テーブル

| Column                    | Type       | Options                        |
| ------------------------- | ---------- | ------------------------------ |
| email                     | string     | null: false, unique: true      |
| encrypted_password        | string     | null: false                    |
| nickname                  | string     | null: false                    |
| profile                   | text       |                                |
| birthday                  | date       | null: false                    |

- has_many :room_users
- has_many :rooms, through: :room_users
- has_many :posts
- has_many :comments


### rooms テーブル

| Column                    | Type       | Options                        |
| ------------------------- | ---------- | ------------------------------ |
| name                      | string     | null: false                    |

- has_many :room_users, dependent: :destroy
- has_many :users, through: :room_users
- has_many :posts, dependent: :destroy


### room_users テーブル

| Column                    | Type       | Options                        |
| ------------------------- | ---------- | ------------------------------ |
| room                      | references | null: false, foreign_key: true |
| user                      | references | null: false, foreign_key: true |

- belongs_to :room
- belongs_to :user


### posts テーブル

| Column                    | Type       | Options                        |
| ------------------------- | ---------- | ------------------------------ |
| title                     | string     | null: false                    |
| type_id                   | integer    | null: false                    |
| date                      | date       |                                |
| start_time                | datetime   |                                |
| end_time                  | datetime   |                                |
| content                   | text       |                                |
| room                      | references | null: false, foreign_key: true |
| user                      | references | null: false, foreign_key: true |

- belongs_to :room
- belongs_to :user
- has_many :comments


### comments テーブル

| Column                    | Type       | Options                        |
| ------------------------- | ---------- | ------------------------------ |
| content                   | text       | null: false                    |
| post                      | references | null: false, foreign_key: true |
| user                      | references | null: false, foreign_key: true |

- belongs_to :post
- belongs_to :user
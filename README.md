# サービス名: STAY with MU（ステイウィズミュー）

## ■サービス概要

自分の好きな曲に対する思いを記録することで曲を「育てていく」サービスです。

好きな曲に対する思い出や好きなポイントなどを追加していくことで、曲のレベルが上がり、音楽愛を数値化することができます。「この曲への愛は誰にも負けない！」という動機を提供することで、音楽愛を記録することを促進します。

## ■ このサービスへの思い・作りたい理由

私は、音楽を聴くこと、ライブへ行くこと、歌うことが好きです。

ただ、寂しい気持ちになることがあります。それは、大好きな曲との思い出を忘れてしまうこと、誰かに好きな音楽の好きなところを語りたいのに言葉にできないことです。

そうならないように、音楽との忘れたくない大切な瞬間や、語りたい推しポイントがあった時はメモに残すようにしている時期もあったのですが、続きませんでした。なぜならめんどくさいから。そこで、音楽への思いを記録したりシェアすること自体にモチベーションを与えられるサービスを作りたいと思い、「曲を育てる」という発想に至りました。

「STAY with MU」は、音楽を「MU」と呼び、音楽愛を記録することでより曲への愛着を育み、相棒のような存在になれたらいいなという思いを込めて名付けました。

## ■ ユーザー層について

好きな音楽との思い出を記録したい人、好きな音楽の推しポイントを共有したい人

## ■サービスの利用イメージ

### MU作成関連

ユーザーは自分の好きな曲をSpotifyの曲情報を元に「MU」として作成できます。作成時には、「曲に出会った日時（曖昧可）」、「曲と出会った時の状況（その頃なにしてた？）」などの項目を記入できます。

また、作成した「MU」に好きなタイミングで、メモリー（呼称未定）という文章を追加できます。メモリーにはタグが追加でき、タグで整理できます。\
タグ例：「思い出」「好きなところ」「好きな歌詞」「ライブ参戦」「カラオケ」「ドライブ」「演奏」「アーティストへの思い」「推し活」など

MU作成時に追加した項目と、追加したメモリーの文字数に応じて経験値(exp)が加算され、経験値に応じてMUのレベルが上がります。また、作成したMUの数、一定のレベルに達したMUの数などの達成項目に応じてユーザーはメダルを獲得でき、アイコンの横に飾ることができます。

### MU一覧、詳細関連

他のユーザーの作成したMUとメモリーを見ることができます。他のユーザーが作成したMU詳細画面では、そのMUに追加されたすべてのメモリーを見ることができ、コメントすることもできます。

## ■ ユーザーの獲得について

- X(旧:Twitter)での発信
- Mattermostでの告知
- 友人に使ってもらう

## ■ サービスの差別化ポイント・推しポイント

音楽の感想を共有するサービスはすでに多く存在(代表例: [Chooning](https://chooning.app/ja), [HOWLUS](https://www.howlus.com/))してしていますが、以下の点で差別化しております。

- **追加した文章の量に応じて曲のレベルが上がる**
    
    作りたいと思った理由に繋がりますが、「音楽愛を発信したい」、「思い出を記録したい」といった純粋な気持ちをモチベーションとするサービスがほとんどですが、それだけだとユーザーの投稿するモチベーションが続かないのではないかと考えました。
    
    そこで、MUのレベルアップ、達成項目によるメダル獲得など、他のユーザーを意識して投稿したくなるような、あえて不純な動機を与えることを意識しました。
    
- **文章の追加を随時行えるため投稿のハードルが低い。**
    
    上記のサービスは1曲に対して1つの文章という形式のため、「読んでもらえる整った文章を考えなければ」という心理がユーザーに働き、投稿のハードルが上がると考えました。
    
    そこで、「思いついたタイミングで」、「全く文脈を気にせず」、「好きなタグをつけて」随時文章の追加を行える形式にすることで、投稿のハードルを下げます。
    

## ■ 機能候補

**MVP**

- 会員登録
- ログイン
- MU作成
    - 曲検索機能
    - メモリー追加機能
    - MUレベルアップ機能
    - Xシェア機能
- みんなのMU一覧機能
    - 検索機能
    - ソート機能
    - いいね機能
- MU詳細
    - コメント機能
- プロフィール機能
    - アイコン、自己紹介編集機能
    - 作成したMU一覧

**MVP以降追加予定機能**

- ユーザーメダル機能
- ユーザーフォロー機能
- プレイリスト作成機能
- 試聴機能
- オートコンプリート機能
- 特定のメモリーを非表示にする機能

## ■機能の実装方針予定
| カテゴリ | 技術 |
| --- | --- |
| 開発環境 | Docker |
| フロントエンド | TailwindCSS, Hotwire |
| バックエンド | Ruby 3.2.2 / Ruby on Rails 7系 |
| データベース | PostgreSQL |
| インフラ | Render |
| Web API | Spotify Web API（gem 'RSpotify'） |

## ■画面遷移図
https://www.figma.com/file/BfMTw56e0vPpTX1UYnTlLN/STAY-with-MU?type=design&node-id=0%3A1&mode=design&t=66aJBbzwX4HLdTwI-1

## ■ER図
![Alt text](ER%E5%9B%B3Stay_with_MU.png)
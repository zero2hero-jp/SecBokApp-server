# SecBokApp-server

## 環境
| 環境 | Cfn Env | URL |
| ---- | ----- | ----- |
| ステージング | dev | http://alb-dev-839971225.ap-northeast-1.elb.amazonaws.com/health_check |
| 本番 | prod | http://alb-prod-184231461.ap-northeast-1.elb.amazonaws.com/health_check |

## 開発環境構築
1. clone
```
$ git clone git@github.com:zero2hero-jp/SecBokApp-server.git

$ cd SeckBokApp-server
```

2. .env.developmentファイルを作成
- 内容は管理者に問合せて下さい。
```
RAILS_LOG_TO_STDOUT=true

DATABASE_HOST=
DATABASE_USER=
DATABASE_PASSWORD=
DATABASE_NAME=
DATABASE_NAME_TEST=
DATABASE_NAME_PRODUCTION=

AWS_REGION=
AWS_ACCOUNT_ID=
```

2. DB作成とマイグレーション
```
$ docker compose run --rm api rails db:create
$ docker compose run --rm api rails db:migrate
```

3. 起動
```
$ docker compose up
```

4. 動作確認
- ブラウザで、`http://localhost/health_check`にアクセス。

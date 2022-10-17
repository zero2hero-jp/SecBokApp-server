# SecBokApp-server

## 環境
| 環境 | Cfn Env | URL |
| ---- | ----- | ----- |
| CDK開発 | local | http://alb-local-1007258061.ap-northeast-1.elb.amazonaws.com/health_check |
| ステージング | dev | http://alb-dev-839971225.ap-northeast-1.elb.amazonaws.com/health_check |
| 本番 | prod | http://alb-prod-184231461.ap-northeast-1.elb.amazonaws.com/health_check |

## 開発環境構築
1. clone
```
$ git clone git@github.com:zero2hero-jp/SecBokApp-server.git

$ cd SeckBokApp-server
```

2. aws情報の設定
- 以下のファイルの設定内容を管理者に問い合わせて入力して下さい。
```
# ~/.aws/config

[profile secbokapp-cdk]
output = json
region = 
aws_access_key_id = 
aws_secret_access_key = 
```

3. .env.developmentファイルを作成
- 以下のファイルの設定内容を管理者に問い合わせて入力して下さい。
```
RAILS_LOG_TO_STDOUT=true

DATABASE_HOST=
DATABASE_USER=
DATABASE_PASSWORD=
DATABASE_NAME=
DATABASE_NAME_TEST=
DATABASE_NAME_PRODUCTION=
```

4. DB作成とマイグレーション
```
$ docker compose run --rm api rails db:create
$ docker compose run --rm api rails db:migrate
```

5. 起動
```
$ docker compose up
```

6. 動作確認
- ブラウザで、`http://localhost/health_check`にアクセス。

## デプロイ
- ステージングへのデプロイは、github上で`development`ブランチにmergeされるとデプロイが開始します。
- 本番へのデプロイは、github上で`main`ブランチにmergeされるとデプロイが開始します。

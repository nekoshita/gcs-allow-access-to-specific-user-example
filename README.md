# GCSバケットに特定のユーザーしかアクセスできなくする

## 解説記事
https://zenn.dev/nekoshita/articles/b04bdc3fee1cd9

## GCSバケットに特定のユーザーしかアクセスできなくする方法
- プロジェクトレベルのIAMで `storage.objects.get` の権限を付与しない
	- プロジェクトレベルのIAMとはここで設定する権限のこと
	- https://console.cloud.google.com/iam-admin/iam
- GCSバケットのアクセス制御は `Uniform` モードで作成する
- バケットの詳細ページでパーミッションを設定する
	- 特定のユーザーだけにアクセス権限を与えるには、デフォルト作成されるOwner、Editor、Viewerに与えられる権限を削除する必要があります
	- https://console.cloud.google.com/storage/browser/あなたのGCSバケット名;tab=permissions

## 今回作成するGCSバケット
アクセスコントロールモードは `Uniform`
アクセス可能なユーザーは
- プロジェクトのオーナー
- bin/apply の引数で指定したユーザー
にしました。（本当はユーザーだけにしたかったけど、自分自身以外のメールアドレスにしてしまうと、自分がGCSバケットを作成する権限がなくなってしまうので、オーナーの権限を残しました）


## GCSバケットの作成
```
$ export GCP_PROJECT_ID="your-gcp-project-id"
$ export GCS_BUCKET_NAME="your-gcs-bucket-name"
$ export USER_MAIL="your-google-user-mail-to-allow-ssh-acccess@gmail.com"

$ bin/apply $GCP_PROJECT_ID $GCS_BUCKET_NAME $USER_MAIL
```

## GCSバケットの削除
```
$ export GCP_PROJECT_ID="your-gcp-project-id"
$ export GCS_BUCKET_NAME="your-gcs-bucket-name"
$ export USER_MAIL="your-google-user-mail-to-allow-ssh-acccess@gmail.com"

$ bin/destroy $GCP_PROJECT_ID $GCS_BUCKET_NAME $USER_MAIL
```

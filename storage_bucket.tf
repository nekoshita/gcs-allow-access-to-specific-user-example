resource "google_storage_bucket" "private_bucket_project_owner_and_one_user_can_access" {
  name     = "private_bucket_project_owner_and_one_user_can_access"
  location = var.gcp_regions["tokyo"]

  # このオプションをtrueにしておくと、バケット内にデータが残っていても削除してくれる
  # 本番運用時はtrueにしない方がおそらくいいが、これはサンプルのためtrueにしておく
  force_destroy = true
}

# IMAポリシーをバケットに付与する
resource "google_storage_bucket_iam_policy" "private_bucket_project_owner_and_one_user_can_access" {
  bucket      = google_storage_bucket.private_bucket_project_owner_and_one_user_can_access.name
  policy_data = data.google_iam_policy.private_bucket_project_owner_and_one_user_can_access.policy_data
}

# リソースレベルのロールを付与するためのIAMポリシーを定義する
data "google_iam_policy" "private_bucket_project_owner_and_one_user_can_access" {
  binding {
    # 定義済みのロール。保有する権限の詳細は以下
    # https://cloud.google.com/storage/docs/access-control/iam-roles#standard-roles
    role = "roles/storage.admin"

    # ロールを付与する対象のユーザーやサービスアカウント
    members = [
      "projectOwner:${var.gcp_project_id}",
    ]
  }

  binding {
    # 定義済みのロール。保有する権限の詳細は以下
    # https://cloud.google.com/storage/docs/access-control/iam-roles#standard-roles
    role = "roles/storage.objectViewer"

    # ロールを付与する対象のユーザーやサービスアカウント
    members = [
      "user:${var.allowed_user_mail}",
    ]
  }
}

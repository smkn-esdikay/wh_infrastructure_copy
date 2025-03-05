locals {
  users = {
    "stackoverdrive" = [
      "KubernetesAdmin",
      "Administrators",
    ],
  }
}

output iam_users {
  value = keys(local.users)
}

module iam_users {
  source     = "../../modules/iam_users/"
  users      = local.users
  aws_root_account_id = "00001"
}

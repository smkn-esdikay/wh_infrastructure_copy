module ecr {
  source = "../../modules/ecr/"
  repos = [
    "frontend",
    "backend"
  ]

  account_ids = [
    local.aws_root_account_id
  ]
}

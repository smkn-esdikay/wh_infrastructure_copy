module primary_cluster {
  source = "../../modules/rds_global_cluster_primary/"

  environment    = local.environment
  cluster_size   = 1
  instance_class = "db.r5.large"
  db_subnet_ids  = module.networking_us_east_1.private_subnet_ids
  availability_zones    = slice(sort(local.availability_zones), 0, 3)
  storage_key_admin_arn = data.terraform_remote_state.bootstrap.outputs.core_infra_role_arn
  engine_version = "14.7"
}

output db_connection_string {
  value = module.primary_cluster.connection_string
  sensitive = true
}

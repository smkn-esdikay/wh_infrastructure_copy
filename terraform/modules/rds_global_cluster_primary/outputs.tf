output global_cluster_identifier {
  value = aws_rds_global_cluster.default.global_cluster_identifier
}

output engine {
  value = aws_rds_global_cluster.default.engine
}

output engine_version {
  value = aws_rds_global_cluster.default.engine_version
}

output endpoint {
  value = aws_rds_cluster.primary.endpoint
}

output master_username {
  value = "root"
}

output master_password {
  value = aws_rds_cluster.primary.master_password
}

output cluster_resource_id {
  value = aws_rds_cluster.primary.cluster_resource_id
}

output connection_string {
  value = "postgres://${aws_rds_cluster.primary.master_username}:${aws_rds_cluster.primary.master_password}@${aws_rds_cluster.primary.endpoint}/${aws_rds_cluster.primary.database_name}"
}

output engine {
  value = aws_rds_cluster.default.engine
}

output engine_version {
  value = aws_rds_cluster.default.engine_version
}

output cluster_resource_id {
  value = aws_rds_cluster.default.cluster_resource_id
}

output reader_endpoint {
  value = aws_rds_cluster.default.reader_endpoint
}

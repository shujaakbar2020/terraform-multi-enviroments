output "s3_bucket_arn" {
  value = module.remote_state.s3_bucket_arn
}

output "dynamodb_table_name" {
  value = module.remote_state.dynamodb_table_name
}

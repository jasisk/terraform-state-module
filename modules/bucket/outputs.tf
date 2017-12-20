output "arn" {
  value = "${var.bucket_prefix != "" ? aws_s3_bucket.state_with_prefix.arn : aws_s3_bucket.state.arn}"
}

output "id" {
  value = "${var.bucket_prefix != "" ? aws_s3_bucket.state_with_prefix.id : aws_s3_bucket.state.id}"
}

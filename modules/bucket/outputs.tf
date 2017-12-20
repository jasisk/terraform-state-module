output "arn" {
  value = "${var.bucket_prefix != "" ? join("|", aws_s3_bucket.state_with_prefix.*.arn) : join("|", aws_s3_bucket.state.*.arn)}"
}

output "id" {
  value = "${var.bucket_prefix != "" ? join("|", aws_s3_bucket.state_with_prefix.*.id) : join("|", aws_s3_bucket.state.*.id)}"
}

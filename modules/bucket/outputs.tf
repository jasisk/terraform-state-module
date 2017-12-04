output "arn" {
  value = "${aws_s3_bucket.state.arn}"
}

output "id" {
  value = "${aws_s3_bucket.state.id}"
}

output "key_arn" {
  value = "${aws_kms_key.state.arn}"
}

output "alias_arn" {
  value = "${aws_kms_alias.state.arn}"
}

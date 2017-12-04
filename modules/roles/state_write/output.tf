output "json" {
  value = "${data.aws_iam_policy_document.terraform_state_write.json}"
}

output "json" {
  value = "${ var.require_mfa ? data.aws_iam_policy_document.mfa_trust_policy.json : data.aws_iam_policy_document.trust_policy.json }"
}

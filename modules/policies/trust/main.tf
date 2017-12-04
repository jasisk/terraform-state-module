data "aws_iam_policy_document" "trust_policy" {
  statement {
    effect = "Allow"
    actions = ["${var.actions}"]
    principals {
      type = "AWS"
      identifiers = ["arn:aws:iam::${var.trusted_account_id}:root"]
    }
  }
}

data "aws_iam_policy_document" "mfa_trust_policy" {
  statement {
    effect = "Allow"
    actions = ["${var.actions}"]
    principals {
      type = "AWS"
      identifiers = ["arn:aws:iam::${var.trusted_account_id}:root"]
    }
    condition {
      test = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values = ["true"]
    }
  }
}

locals {
  tags = {
    LastModifiedTime = "${timestamp()}"
    LastModifiedBy = "${var.modified_by}"
  }
}

resource "aws_kms_key" "state" {
  description = "state encryption key for ${var.name}"
  policy = "${data.aws_iam_policy_document.key_trust_policy.json}"
  lifecycle {
    ignore_changes = ["tags.LastModifiedTime", "tags.LastModifiedBy"]
  }
  tags = "${merge(var.tags, local.tags)}"
}

resource "aws_kms_alias" "state" {
  name_prefix = "alias/state-${var.name}-"
  target_key_id = "${aws_kms_key.state.id}"
}

data "aws_iam_policy_document" "key_trust_policy" {
  statement {
    effect = "Allow"
    actions = ["kms:*"]
    resources = ["*"]
    principals {
      type = "AWS"
      identifiers = ["arn:aws:iam::${var.trusted_account_id}:root"]
    }
  }
}

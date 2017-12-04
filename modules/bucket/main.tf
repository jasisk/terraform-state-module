locals {
  # require_encryption = "${var.encryption_type == "kms" || var.encryption_type == "aes"}"
  require_encryption = "${var.encryption_type == "aes"}"
  encryption_header = {
    kms = "aws:kms"
    aes = "AES256"
  }
  tags = {
    LastModifiedTime = "${timestamp()}"
    LastModifiedBy = "${var.modified_by}"
  }
}

resource "aws_s3_bucket" "state" {
  bucket_prefix = "tf-state-${var.bucket_prefix}-"

  versioning {
    enabled = true
  }

  lifecycle {
    ignore_changes = ["tags.LastModifiedTime", "tags.LastModifiedBy"]
  }

  tags = "${merge(var.tags, local.tags)}"
}

data "aws_iam_policy_document" "bucket_require_sse" {
  count = "${local.require_encryption ? 1 : 0}"
  # https://aws.amazon.com/blogs/security/how-to-prevent-uploads-of-unencrypted-objects-to-amazon-s3/
  policy_id = "PutObjPolicy"

  statement {
    sid = "DenyIncorrectEncryptionHeader"
    effect = "Deny"
    principals {
      type = "AWS"
      identifiers = ["*"]
    }

    actions = ["s3:PutObject"]
    resources = ["$${arn}/*"]

    condition {
      test = "StringNotEquals"
      variable = "s3:x-amz-server-side-encryption"
      values = ["${lookup(local.encryption_header, var.encryption_type)}"]
    }
  }

  statement {
    sid = "DenyUnencryptedObjectUploads"
    effect = "Deny"
    principals {
      type = "AWS"
      identifiers = ["*"]
    }

    actions = ["s3:PutObject"]
    resources = ["$${arn}/*"]

    condition {
      test = "Null"
      variable = "s3:x-amz-server-side-encryption"
      values = ["true"]
    }
  }
}

data "template_file" "bucket_policy" {
  count = "${local.require_encryption ? 1 : 0}"

  template = "${data.aws_iam_policy_document.bucket_require_sse.json}"

  vars {
    arn = "${aws_s3_bucket.state.arn}"
  }
}

resource "aws_s3_bucket_policy" "state" {
  count = "${local.require_encryption ? 1 : 0}"

  bucket = "${aws_s3_bucket.state.id}"
  policy = "${data.template_file.bucket_policy.rendered}"
}

data "aws_iam_policy_document" "terraform_state_write" {

  statement {
    sid = "AllowTerraformStateWriteBucket"

    actions = [
      "s3:listBucket",
      "s3:getObject",
      "s3:putObject",
      "s3:deleteObject"
    ]

    resources = [
      "${var.bucket_arn}",
      "${var.bucket_arn}/*"
    ]
  }
}

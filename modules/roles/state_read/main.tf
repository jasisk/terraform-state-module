data "aws_iam_policy_document" "terraform_state_read" {

  statement {
    sid = "AllowTerraformStateReadListBucket"

    actions = [
      "s3:listBucket"
    ]

    resources = [
      "${var.bucket_arn}"
    ]
  }

  statement {
    sid = "AllowTerraformStateReadGetObject"

    actions = [
      "s3:getObject"
    ]

    resources = [
      "${var.bucket_arn}/*"
    ]
  }

}

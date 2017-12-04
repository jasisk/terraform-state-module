module "mfa_trust_policy" {
  source = "../policies/trust/"

  trusted_account_id = "${var.trusted_account_id}"
  actions = ["sts:AssumeRole"]
  require_mfa = true
}

module "trust_policy" {
  source = "../policies/trust/"

  trusted_account_id = "${var.trusted_account_id}"
  actions = ["sts:AssumeRole"]
}

module "terraform_state_read_policy" {
  source = "./state_read/"

  bucket_arn = "${var.bucket_arn}"
}

module "terraform_state_write_policy" {
  source = "./state_write/"

  bucket_arn = "${var.bucket_arn}"
}

resource "aws_iam_role" "terraform_state_read" {
  name_prefix = "terraform-state-read-"
  assume_role_policy = "${module.trust_policy.json}"
}

resource "aws_iam_policy" "terraform_state_read" {
  name_prefix = "terraform-state-read-"
  policy = "${module.terraform_state_read_policy.json}"
}

resource "aws_iam_role" "terraform_state_write" {
  name_prefix = "terraform-state-write-"
  assume_role_policy = "${module.mfa_trust_policy.json}"
}

resource "aws_iam_policy" "terraform_state_write" {
  name_prefix = "terraform-state-write-"
  policy = "${module.terraform_state_write_policy.json}"
}

resource "aws_iam_role_policy_attachment" "terraform_state_read" {
  role = "${aws_iam_role.terraform_state_read.name}"
  policy_arn = "${aws_iam_policy.terraform_state_read.arn}"
}

resource "aws_iam_role_policy_attachment" "terraform_state_admin_read" {
  role = "${aws_iam_role.terraform_state_write.name}"
  policy_arn = "${aws_iam_policy.terraform_state_read.arn}"
}

resource "aws_iam_role_policy_attachment" "terraform_state_admin_write" {
  role = "${aws_iam_role.terraform_state_write.name}"
  policy_arn = "${aws_iam_policy.terraform_state_write.arn}"
}

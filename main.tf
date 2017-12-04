provider "aws" {}

module "bucket" {
  source = "./modules/bucket"

  bucket_prefix = "${var.bucket_prefix}"
  modified_by = "${var.caller_arn}"
}

module "roles" {
  source = "./modules/roles"

  bucket_arn = "${module.bucket.arn}"
  trusted_account_id = "${var.trusted_account_id}"
}

module "backend_config" {
  source = "./modules/files"

  write_backend_config = "${var.write_backend_config}"
  write_remote_state_data = "${var.write_remote_state_data}"
  state_file_path = "${var.state_file_path}"
  bucket_id = "${module.bucket.id}"
  admin_role_arn = "${module.roles.state_admin_arn}"
  read_role_arn = "${module.roles.state_read_arn}"
  remote_state_name = "${var.name}"
  aws_region = "${var.aws_region}"
}

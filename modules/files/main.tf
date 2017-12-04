resource "local_file" "backend_conf" {
  count = "${var.write_backend_config ? 1 : 0}"

  filename = "${path.root}/remote_state_configs/s3_backend.tf"
  content = <<EOF
terraform {
  backend "s3" {
    key = "${var.state_file_path}"
    bucket = "${var.bucket_id}"
    role_arn = "${var.admin_role_arn}"
    region = "${var.aws_region}"
    encrypt = true
  }
}
EOF
}

resource "local_file" "remote_state_data" {
  count = "${var.write_remote_state_data ? 1 : 0}"

  filename = "${path.root}/remote_state_configs/s3_remote_state.tf"
  content = <<EOF
data "terraform_remote_state" "${var.remote_state_name}" {
  backend = "s3"
  environment = "${terraform.workspace}"
  config {
    bucket = "${var.bucket_id}"
    key = "${var.state_file_path}"
    region = "${var.aws_region}"
    encrypt = true
    role = "${var.read_role_arn}"
  }
}
EOF
}

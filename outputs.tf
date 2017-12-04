output "bucket" {
  value = {
    id = "${module.bucket.id}"
    arn = "${module.bucket.arn}"
  }
}

output "roles" {
  value {
    state_read = "${module.roles.state_read_arn}"
    state_admin = "${module.roles.state_admin_arn}"
  }
}

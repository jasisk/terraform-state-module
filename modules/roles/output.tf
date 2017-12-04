output "state_read_arn" {
  value = "${aws_iam_role.terraform_state_read.arn}"
} 

output "state_admin_arn" {
  value = "${aws_iam_role.terraform_state_write.arn}"
} 

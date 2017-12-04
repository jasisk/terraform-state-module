variable "aws_region" {
  type = "string"
}

variable "state_file_path" {
  type = "string"
}

variable "write_remote_state_data" {
  type = "string"
}

variable "write_backend_config" {
  type = "string"
}

variable "bucket_id" {
  type = "string"
}

variable "admin_role_arn" {
  type = "string"
}

variable "read_role_arn" {
  type = "string"
}

variable "remote_state_name" {
  type = "string"
}

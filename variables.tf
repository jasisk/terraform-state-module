variable "bucket_prefix" {
  type = "string"
}

variable "trusted_account_id" {
  type = "string"
}

variable "caller_arn" {
  type = "string"
}

variable "state_file_path" {
  default = "terraform.tfstate"
}

variable "write_backend_config" {
  default = "false"
}

variable "write_remote_state_data" {
  default = "false"
}

variable "name" {
  type = "string"
}

variable "aws_region" {
  type = "string"
}

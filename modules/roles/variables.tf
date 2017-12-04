variable "bucket_arn" {
  type = "string"
}

variable "with_kms" {
  default = false
}

variable "trusted_account_id" {
  type = "string"
}

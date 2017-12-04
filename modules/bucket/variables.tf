variable "bucket_prefix" {
  type = "string"
}

variable "tags" {
  default = {}
}

variable "modified_by" {
  type = "string"
}

variable "encryption_type" {
  default = "aes"
  description = "optional variable for sse (options: kms, aes)"
}

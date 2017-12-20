variable "bucket_prefix" {
  default = ""
}

variable "bucket" {
  default = ""
}

variable "tags" {
  default = {}
}

variable "encryption_type" {
  default = "aes"
  description = "optional variable for sse (options: kms, aes)"
}

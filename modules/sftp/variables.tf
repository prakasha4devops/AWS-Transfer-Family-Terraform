variable "name" {
  default = "nep-interview-sftp"
}

variable "tags" {
  default = {}
}

variable "users" {
  default     = {}
  description = "User name(s) for SFTP server"
}
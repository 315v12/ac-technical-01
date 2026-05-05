variable "name" {
  type = string
}

variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "instance_count" {
  type    = number
  default = 1
}

variable "user_data" {
  type    = string
  default = ""
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "ssh_cidr_blocks" {
  type = list(string)
}

variable "http_cidr_blocks" {
  type    = list(string)
  default = []
}

variable "network_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "v4_cidr_blocks" {
  type = list(string)
}

variable "zone" {
  type = string
}

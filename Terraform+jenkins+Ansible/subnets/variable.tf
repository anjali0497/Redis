variable "vpc_id" {
  type = string
}

variable "vpc-cidr" {
  type = string
}

variable "pri-sub1-az" {
  type = string
  default = "ap-southeast-2b"
}

variable "pri-sub2-az" {
  type = string
  default = "ap-southeast-2a"
}

variable "pub-sub-az" {
  type = string
  default = "ap-southeast-2a"
}

variable "pub-cidr" {
  type = string
  default = "10.0.1.0/24"
}

variable "pri-sub-2-cidr" {
  type = string
  default = "10.0.2.0/24"
}

variable "pri-sub-1-cidr" {
  type = string
  default = "10.0.3.0/24"
}
variable "vpc-cidr" {
    type = string
}

variable "nat-gat-id" {
    type = string
}
variable "pri-rt-cidr" {
    type = string
    default = "0.0.0.0/0"
}

variable "pub-rt-cidr" {
    type = string
    default = "0.0.0.0/0"
}

variable "pub-sub-id" {
  type = string
}

variable "pri-sub-id" {
  type = string
}

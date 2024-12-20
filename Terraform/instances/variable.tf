variable "public-sg-id" {
  type = string
}

variable "private-sg-id" {
  type = string
}

variable "pub-sub-id" {
  type = string  
}

variable "pri-sub-1-id" {
  type = string  
}

variable "pri-sub-2-id" {
  type = string  
}

variable "ami-id" {
  type = string
  default = "ami-0892a9c01908fafd1"
}

variable "instance-type" {
  type = string
  default = "t2.micro"
}

variable "key-name" {
  type = string
  default = "sydney-key"
}
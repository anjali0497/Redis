output "vpc_id" {
  value = aws_vpc.Redis-VPC.id
}

output "vpc-cidr" {
  value = var.vpc-cidr
}
# Get the default VPC
data "aws_vpc" "default" {
  default = true
}

# Default VPC Security Group
resource "aws_security_group" "default_vpc_sg" {
  vpc_id = data.aws_vpc.default.id
  name   = "default-vpc-sg"
  
  # Allow inbound traffic from the custom VPC
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]   # Corrected variable reference for VPC CIDR
  }

  # Allow all outbound traffic (optional)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"        # All protocols
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Public Security Group
resource "aws_security_group" "public-SG" {
  vpc_id = var.vpc_id   # Corrected to use 'var.vpc_id'

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]   # Allow all outbound traffic
  }

  # Ingress rule for SSH (port 22)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Ingress rule for HTTP (port 80)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Ingress rule for ICMP (ping) from the default VPC security group
  ingress {
    from_port        = -1                # ICMP type (all types)
    to_port          = -1                # ICMP code (all codes)
    protocol         = "icmp"
    security_groups  = [aws_security_group.default_vpc_sg.id]  # Reference to the resource
    ipv6_cidr_blocks = []
  }

  tags = {
    Name = "public-sg"
  }
}

# Private Security Group
resource "aws_security_group" "private-SG" {
  vpc_id = var.vpc_id   # Corrected to use 'var.vpc_id'

  # Ingress rule for Redis (port 6379)
  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"]  # Custom CIDR block
  }

  # Ingress rule for SSH (port 22)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"]
  }

  # Ingress rule for ICMP (ping) from the default VPC security group
  ingress {
    from_port        = -1                # ICMP type (all types)
    to_port          = -1                # ICMP code (all codes)
    protocol         = "icmp"
    security_groups  = [aws_security_group.default_vpc_sg.id]  # Reference to the resource
    ipv6_cidr_blocks = []
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"        # All protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "private-sg"
  }
}

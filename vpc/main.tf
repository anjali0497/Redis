# VPC
resource "aws_vpc" "Redis-VPC" {
  cidr_block = var.vpc-cidr

  tags = {
    Name = "Redis-VPC"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "Assi-4-IGW" {
  vpc_id = aws_vpc.Redis-VPC.id

  tags = {
    Name = "Assi-IGW"
  }
}

#public route table
resource "aws_route_table" "public-RT" {
  vpc_id = aws_vpc.Redis-VPC.id

  route {
    cidr_block = var.pub-rt-cidr
    gateway_id = aws_internet_gateway.Assi-4-IGW.id
  }

  tags = {
    Name = "public-route-table"
  }
}

# private route table
resource "aws_route_table" "private-RT" {
  vpc_id = aws_vpc.Redis-VPC.id

  route {
    cidr_block     = var.pri-rt-cidr
    nat_gateway_id = var.nat-gat-id
  }

  tags = {
    Name = "private-route-table"
  }
}

# Associate Public Route Table with Public Subnet
resource "aws_route_table_association" "public" {
  subnet_id      = var.pub-sub-id
  route_table_id = aws_route_table.public-RT.id
}

# Associate Private Route Table with Private Subnet
resource "aws_route_table_association" "private" {
  subnet_id      = var.pri-sub-id
  route_table_id = aws_route_table.private-RT.id
}
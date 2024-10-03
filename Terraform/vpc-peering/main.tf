data "aws_vpc" "default_vpc" {
  default = true
}


resource "aws_vpc_peering_connection" "vpc_peering" {
  vpc_id        = data.aws_vpc.default_vpc.id              
  peer_vpc_id   = var.vpc_id        
  peer_region   = var.region_name         
  tags = {
    Name = "peering connection"
  }
}

resource "aws_vpc_peering_connection_accepter" "accepter" {
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
  auto_accept               = true
}

data "aws_route_table" "default_RT" {
  vpc_id = data.aws_vpc.default_vpc.id
  filter {
    name = "association.main"
    values = [ "true" ]

  }
}

resource "aws_route" "default_rt" {
route_table_id = data.aws_route_table.default_RT.id
destination_cidr_block = var.vpc-cidr
vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
}

data "aws_security_group" "default_sg" {
  vpc_id = data.aws_vpc.default_vpc.id
  filter {
    name = "group-name"
    values = [ "default" ]
  }
}






/*

# Route traffic from the custom VPC to the default VPC
resource "aws_route" "custom_to_default" {
  route_table_id         = aws_vpc.Redis-VPC.main_route_table_id
  destination_cidr_block = data.aws_vpc.default_vpc.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}

# Create a VPC peering connection between the default VPC and custom VPC
resource "aws_vpc_peering_connection" "peer" {
  vpc_id        = data.aws_vpc.default_vpc.id         # Default VPC
  peer_vpc_id   = aws_vpc.Redis-VPC.id           # Custom VPC
  auto_accept   = true  # Automatically accept the peering request

  tags = {
    Name = "Default-to-Custom-VPC-Peering"
  }
}

# Route traffic from the default VPC to the custom VPC
resource "aws_route" "default_to_custom" {
  route_table_id         = data.aws_vpc.default_vpc.main_route_table_id
  destination_cidr_block = aws_vpc.Redis-VPC.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}*/
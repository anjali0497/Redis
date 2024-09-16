# Public EC2 Instance
resource "aws_instance" "Redis-public" {
  ami           = var.ami-id
  instance_type = var.instance-type
  subnet_id     = var.pub-sub-id
  security_groups = [var.public-sg-id]

  tags = {
    Name = "Redis-public"
  }
}

# Private EC2 1 Instance
resource "aws_instance" "Redis-private-1" {
  ami           = var.ami-id
  instance_type = var.instance-type
  subnet_id     = var.pri-sub-1-id
  security_groups = [var.private-sg-id]

  tags = {
    Name = "Redis-private-1"
  }
}

# Private EC2 2 Instance
resource "aws_instance" "Redis-private-2" {
  ami           = var.ami-id
  instance_type = var.instance-type
  subnet_id     = var.pri-sub-2-id
  security_groups = [var.private-sg-id]  
          
  tags = {
    Name = "Redis-private-2"
  }
}
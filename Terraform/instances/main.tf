# Public EC2 Instance
resource "aws_instance" "Redis-public" {
  ami           = var.ami-id
  instance_type = var.instance-type
  subnet_id     = var.pub-sub-id
  associate_public_ip_address = "true"
  security_groups = [var.public-sg-id]
  key_name = var.key-name

   # User Data to add public SSH key to the instance
  user_data = <<-EOF
              #!/bin/bash
              mkdir -p /home/ubuntu/.ssh
              echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCUBnJlQOlvJtJbLVW6zU+s5SlfO8rXz1wPrR3eMLCYeRSpFZlGeTJlBK9MzyzfNB5+iUEMVXQo6AaJcQn8BMzhG0sWqu+ROLJgOaxF+BYRs10mkeHNwGypzskSFPQoTvgW0pI/FvHt/0T4//bpKLsugvSHcTApxb5TGy2D3atd+qymo9oC0Z/fNAr73xHrBCboWPNfsXHVT/GAicfG6sIgmtTJNEubrWghVTbmYIzS4hYgcjMGfFENYcc5Cp0NPlU4v2k6BrkZjYIwUqJUx829F18XiWbXHOMZLlBY80cGNXWz1+hmsjuACau5SQ8kMaMjMFK+dFR7krwlmMg1e15/ sydney-key" >> /home/ubuntu/.ssh/authorized_keys && \
              chmod 700 /home/ubuntu/.ssh && \
              chmod 600 /home/ubuntu/.ssh/authorized_keys && \ 
              chown -R ubuntu:ubuntu /home/ubuntu/.ssh
              EOF

  tags = {
    Name = "Redis-public"
  }
}

# Private EC2 1 Instance
resource "aws_instance" "Redis-private-1" {
  ami           = var.ami-id
  instance_type = var.instance-type
  subnet_id     = var.pri-sub-1-id
  associate_public_ip_address = "false"
  security_groups = [var.private-sg-id]
  key_name = var.key-name

  tags = {
    Name = "Redis-private-1"
  }
}

# Private EC2 2 Instance
resource "aws_instance" "Redis-private-2" {
  ami           = var.ami-id
  instance_type = var.instance-type
  subnet_id     = var.pri-sub-2-id
  associate_public_ip_address = "false"
  security_groups = [var.private-sg-id]  
   key_name = var.key-name

  tags = {
    Name = "Redis-private-2"
  }
}

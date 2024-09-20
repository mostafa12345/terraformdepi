resource "aws_security_group" "bastion" {
  description = "Allow SSH traffic"
  vpc_id      = var.vpc_id


   ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "bastion_security_group"
  }
}


resource "aws_instance" "bastion" {
  ami           = "ami-06c68f701d8090592"
  instance_type = "t2.micro"
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [aws_security_group.bastion.id]
  key_name      = "test"
  associate_public_ip_address = true
  
  user_data = <<-EOF
             #!/bin/bash
             sudo yum update -y
             sudo yum install docker -y
             sudo systemctl start docker
             sudo systemctl enable docker
             sudo usermod -a -G docker $(whoami)
             newgrp docker
             docker run --name my-nginx -p 8080:80 -d nginx
             EOF

  tags = {
    Name = "BastionHost"
  }
}



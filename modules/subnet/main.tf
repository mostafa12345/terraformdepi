resource "aws_subnet" "subnet-public-01a" {
  vpc_id     = var.vpc_id
  cidr_block = var.dev_subnet1_cidr_block
  availability_zone = "us-east-1a"

  tags = {
    Name = "subnet-public-01a"
  }
}

resource "aws_route_table" "rt-01" {
  vpc_id = var.vpc_id
 route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw-01.id
  }
tags = {
  Name = "rt-01"
 }
}

resource "aws_internet_gateway" "gw-01" {
  vpc_id = var.vpc_id

  tags = {
    Name = "gw-01"
  }
}

resource "aws_route_table_association" "art-01a" {
 subnet_id   = aws_subnet.subnet-public-01a.id
 route_table_id = aws_route_table.rt-01.id
}


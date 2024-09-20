resource "aws_vpc" "vpc-01" {
  cidr_block           = var.dev_vpc1_cidr_block
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "vpc-01"
  }
}


module "myapp-subnet" {
    source = "./modules/subnet"
    vpc_id =  aws_vpc.vpc-01.id
    dev_subnet1_cidr_block = var.dev_subnet1_cidr_block
}


module "myapp-server" {
   source = "./modules/server"
   vpc_id =  aws_vpc.vpc-01.id
   subnet_id = module.myapp-subnet.subnet-details.id
}




terraform {
  required_version = ">= 0.12"
  backend "s3" {
    bucket = "mbahraoui-myapp-bucket"
    key = "myapp/state.tfstate"
    region = "eu-west-3"
  }
}

provider "aws" {
    region = "eu-west-3"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = var.vpc_cidr_block

  azs             = [var.avail_zone]
  public_subnets  = [var.subnet_cidr_block]

  tags = {
    Name = "${var.env_prefix}-vpc"
  }

  public_subnet_tags = {
    Name : "${var.env_prefix}-subnet"
  }
}

module "myapp-webserver" {
  source = "./modules/webserver"
  vpc_id = module.vpc.vpc_id
  my_ip = var.my_ip
  env_prefix = var.env_prefix
  public_key_location = var.public_key_location
  instance_type = var.instance_type
  subnet_id = module.vpc.public_subnets[0]
  avail_zone = var.avail_zone
  image_name = var.image_name
}




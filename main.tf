# Main Terraform configuration file

module "network" {
  source     = "./modules/network"
  vpc_cidr   = "10.0.0.0/16"
  subnet_cidr = "10.0.1.0/24"
  az         = "us-west-2a"
  tags = local.common_tags
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = "agitask02-bucket"
  tags        = local.common_tags
}

module "iam" {
  source    = "./modules/iam"
  user_name = "agitask02-user"
  tags      = local.common_tags
}

module "ec2" {
  source              = "./modules/ec2"
  ami                 = "ami-06a974f9b8a97ecf2" # Amazon Linux 2 AMI for us-west-2
  instance_type       = "t3.micro"
  subnet_id           = module.network.subnet_id
  instance_name       = "agitask02-instance"
  security_group_ids  = [module.network.security_group_id]
  tags                = local.common_tags
}

locals {
  common_tags = {
    Owner   = "Meghana.Menon@agilisium.com"
    Project = "Devops"
    Name    = "agitask02"
    User    = "Karthikraj.Madeshwaran@agilisium.com"
  }
}

provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket       = "terraform-state-multi-cloud-setup-dev"
    key          = "dev/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}

module "networking" {
  source              = "../../modules/networking"
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  az                  = var.az
  env                 = "dev"
  allowed_ssh_cidr    = var.allowed_ssh_cidr
  app_port            = var.app_port
}

module "compute" {
  source = "../../modules/compute"

  ami_id        = var.ami_id
  instance_type = var.instance_type

  subnet_id          = module.networking.subnet_id
  security_group_ids = module.networking.security_group_ids

  key_name = var.key_name

  env = var.env
}

module "compute_private" {
  source = "../../modules/compute"

  ami_id        = var.ami_id
  instance_type = var.instance_type

  subnet_id          = module.networking.private_subnet_id
  security_group_ids = module.networking.security_group_ids

  key_name = var.key_name

  env = "${var.env}-private"
}

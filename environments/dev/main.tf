provider "aws" {
  region = var.region
}

module "networking" {
  source      = "../../modules/networking"
  vpc_cidr    = var.vpc_cidr
  environment = "dev"
}

module "compute" {
  source        = "../../modules/compute"
  environment   = "dev"
  instance_type = var.instance_type
  ami_id        = var.ami_id
  subnet_id     = module.networking.subnet_id
}

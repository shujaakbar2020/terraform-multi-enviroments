provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket         = "terraform-state-multi-cloud-setup-abcd"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
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

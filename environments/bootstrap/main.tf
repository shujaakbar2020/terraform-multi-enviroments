provider "aws" {
  region = "us-east-1"
}

module "remote_state" {
  source      = "../../modules/remote-state"
  bucket_name = "terraform-state-multi-cloud-setup-abcd" # Ensure this is unique
  table_name  = "terraform-state-locks"
}


module "remote_state" {
  source      = "../../modules/remote-state"
  bucket_name = "terraform-state-multi-cloud-dev" # Ensure this is unique
  table_name  = "terraform-state-locks"
}

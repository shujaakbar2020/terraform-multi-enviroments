output "vpc_id" {
  value = module.networking.vpc_id
}

output "instance_public_ip" {
  value = module.compute.private_ip
}

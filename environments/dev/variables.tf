variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR for VPC"
  type        = string
}

variable "instance_type" {
  description = "Instance Type"
  type        = string
}

variable "ami_id" {
  description = "AMI ID"
  type        = string
}

variable "key_name" {
  type    = string
  default = "multi_cloud_setup"
}

variable "public_subnet_cidr" {
  type = string
}

variable "private_subnet_cidr" {
  type = string
}

variable "az" {
  description = "Availability Zone"
  type        = string
}

variable "env" {
  type = string
}

variable "allowed_ssh_cidr" {
  description = "CIDR allowed to SSH public resources"
  type        = string
  default     = "0.0.0.0/0" # tighten in prod!
}

variable "app_port" {
  description = "Application port (example 80, 443, 3000)"
  type        = number
  default     = 80
}

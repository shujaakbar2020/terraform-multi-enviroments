variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
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

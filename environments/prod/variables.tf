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

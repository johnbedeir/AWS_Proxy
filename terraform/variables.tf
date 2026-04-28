variable "aws_region" {
  type        = string
  description = "AWS region for all resources."
  default     = "us-east-1"
}

variable "project_name" {
  type        = string
  description = "Prefix for resource naming."
  default     = "private-proxy-demo"
}

variable "ssh_cidr" {
  type        = string
  description = "CIDR allowed to SSH to the public proxy (port 22). Restrict to your public IP/32 for production."
  default     = "0.0.0.0/0"
}

variable "key_name" {
  type        = string
  nullable    = true
  default     = null
  description = "EC2 key pair name in this region for SSH to the proxy. Omit or null = no key (HTTP demo only)."
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type for proxy and backend."
  default     = "t3.micro"
}

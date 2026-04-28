data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  # Require the general-purpose AL2023 AMI. A broad pattern like al2023-ami-*-kernel-*
  # often resolves to ECS-optimized images first; those are a poor fit for this demo.
  filter {
    name   = "name"
    values = ["al2023-ami-2023*-kernel-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

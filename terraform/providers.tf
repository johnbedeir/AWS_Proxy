# Uses default credential chain: env vars, ~/.aws/credentials default profile, IAM role, etc.
provider "aws" {
  region = var.aws_region
}

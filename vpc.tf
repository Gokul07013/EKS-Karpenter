################################################################################
# VPC
################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.6.1"

  name = "${var.project}-vpc"
  cidr = var.cidr

  azs             = var.az
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway      = false
  enable_vpn_gateway      = false
  map_public_ip_on_launch = true

  public_subnet_tags = {
    "karpenter.sh/discovery" = "karpenter"
  }

  tags = {
    Environment = var.environment
  }
}